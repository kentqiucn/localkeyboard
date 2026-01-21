import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:localsend_app/model/state/remote_keyboard_state.dart';
import 'package:localsend_app/provider/device_info_provider.dart';
import 'package:localsend_app/provider/settings_provider.dart';
import 'package:logging/logging.dart';
import 'package:refena_flutter/refena_flutter.dart';
import 'package:uuid/uuid.dart';

final _logger = Logger('RemoteKeyboard');
const _uuid = Uuid();

/// Provider for remote keyboard receiver (the machine that receives input)
final remoteKeyboardReceiverProvider = NotifierProvider<RemoteKeyboardReceiverService, RemoteKeyboardReceiverState>(
  (ref) => RemoteKeyboardReceiverService(),
);

/// Provider for remote keyboard sender (the machine that sends input)
final remoteKeyboardSenderProvider = NotifierProvider<RemoteKeyboardSenderService, RemoteKeyboardSenderState>(
  (ref) => RemoteKeyboardSenderService(),
);

class RemoteKeyboardReceiverService extends Notifier<RemoteKeyboardReceiverState> {
  HttpServer? _httpServer;
  final Map<String, WebSocket> _connectedClients = {};
  StreamSubscription? _serverSubscription;
  
  // Callback for when text is received
  void Function(String text)? onTextReceived;

  @override
  RemoteKeyboardReceiverState init() {
    return const RemoteKeyboardReceiverState();
  }

  /// Start listening for remote keyboard connections
  Future<bool> startListening({int port = 53318}) async {
    if (state.isListening) {
      _logger.info('Already listening for remote keyboard connections');
      return true;
    }

    try {
      _httpServer = await HttpServer.bind('0.0.0.0', port);
      _logger.info('Remote keyboard server started on port $port');

      _serverSubscription = _httpServer!.listen((HttpRequest request) async {
        if (request.uri.path == '/keyboard/ws') {
          // WebSocket upgrade
          try {
            final socket = await WebSocketTransformer.upgrade(request);
            _handleWebSocketConnection(socket, request);
          } catch (e) {
            _logger.warning('Failed to upgrade to WebSocket: $e');
            request.response.statusCode = HttpStatus.badRequest;
            await request.response.close();
          }
        } else if (request.uri.path == '/keyboard/ping') {
          // Simple ping endpoint for discovery
          final alias = ref.read(settingsProvider).alias;
          request.response
            ..statusCode = HttpStatus.ok
            ..headers.contentType = ContentType.json
            ..write(jsonEncode({
              'alias': alias,
              'type': 'remote_keyboard_receiver',
              'version': '1.0',
            }));
          await request.response.close();
        } else {
          request.response.statusCode = HttpStatus.notFound;
          await request.response.close();
        }
      });

      state = state.copyWith(
        isListening: true,
        port: port,
      );

      return true;
    } catch (e) {
      _logger.severe('Failed to start remote keyboard server: $e');
      return false;
    }
  }

  void _handleWebSocketConnection(WebSocket socket, HttpRequest request) {
    final clientId = _uuid.v4();
    final clientIp = request.connectionInfo?.remoteAddress.address ?? 'unknown';
    
    _logger.info('New remote keyboard connection from $clientIp');

    _connectedClients[clientId] = socket;

    // Send welcome message
    socket.add(jsonEncode({
      'type': 'connected',
      'message': 'Connected to remote keyboard receiver',
      'receiverAlias': ref.read(settingsProvider).alias,
    }));

    socket.listen(
      (data) {
        _handleMessage(clientId, data);
      },
      onDone: () {
        _logger.info('Client $clientId disconnected');
        _connectedClients.remove(clientId);
        _updateConnectedDevices();
      },
      onError: (error) {
        _logger.warning('WebSocket error from $clientId: $error');
        _connectedClients.remove(clientId);
        _updateConnectedDevices();
      },
    );

    _updateConnectedDevices();
  }

  void _handleMessage(String clientId, dynamic data) {
    try {
      final json = jsonDecode(data as String) as Map<String, dynamic>;
      final type = json['type'] as String?;

      if (type == 'register') {
        // Client is registering itself
        final alias = json['alias'] as String? ?? 'Unknown Device';
        final ip = json['ip'] as String? ?? 'unknown';
        final port = json['port'] as int? ?? 0;

        final device = RemoteKeyboardDevice(
          id: clientId,
          alias: alias,
          ip: ip,
          port: port,
          connectedAt: DateTime.now(),
        );

        final devices = [...state.connectedDevices];
        devices.removeWhere((d) => d.id == clientId);
        devices.add(device);

        state = state.copyWith(connectedDevices: devices);
        _logger.info('Device registered: $alias ($ip)');
      } else if (type == 'keyboard_input') {
        // Handle keyboard input
        final inputType = json['inputType'] as String?;
        final content = json['content'] as String?;
        final senderAlias = json['senderAlias'] as String? ?? 'Unknown';

        _processKeyboardInput(inputType, content, senderAlias);
      }
    } catch (e) {
      _logger.warning('Failed to parse message: $e');
    }
  }

  void _processKeyboardInput(String? inputType, String? content, String senderAlias) {
    switch (inputType) {
      case 'text':
        if (content != null) {
          _logger.info('Received text from $senderAlias: $content');
          state = state.copyWith(
            lastReceivedText: content,
            lastReceivedAt: DateTime.now(),
          );
          onTextReceived?.call(content);
        }
        break;
      case 'paste':
        if (content != null) {
          _logger.info('Received paste from $senderAlias: $content');
          state = state.copyWith(
            lastReceivedText: content,
            lastReceivedAt: DateTime.now(),
          );
          onTextReceived?.call(content);
        }
        break;
      case 'backspace':
        _logger.info('Received backspace from $senderAlias');
        onTextReceived?.call('\b'); // Backspace character
        break;
      case 'enter':
        _logger.info('Received enter from $senderAlias');
        onTextReceived?.call('\n');
        break;
      case 'clear':
        _logger.info('Received clear from $senderAlias');
        state = state.copyWith(lastReceivedText: '');
        onTextReceived?.call('\x1b[2K'); // Clear line escape sequence
        break;
    }
  }

  void _updateConnectedDevices() {
    final activeDevices = state.connectedDevices
        .where((d) => _connectedClients.containsKey(d.id))
        .toList();
    state = state.copyWith(connectedDevices: activeDevices);
  }

  /// Stop listening for remote keyboard connections
  Future<void> stopListening() async {
    _logger.info('Stopping remote keyboard server');
    
    // Close all client connections
    for (final socket in _connectedClients.values) {
      await socket.close();
    }
    _connectedClients.clear();

    await _serverSubscription?.cancel();
    await _httpServer?.close(force: true);
    _httpServer = null;

    state = const RemoteKeyboardReceiverState();
  }

  /// Broadcast a message to all connected clients
  void broadcast(String message) {
    for (final socket in _connectedClients.values) {
      socket.add(message);
    }
  }
}

class RemoteKeyboardSenderService extends Notifier<RemoteKeyboardSenderState> {
  WebSocket? _socket;
  StreamSubscription? _subscription;
  Timer? _reconnectTimer;
  
  // Callback for connection status changes
  void Function(bool connected, String? alias)? onConnectionChanged;

  @override
  RemoteKeyboardSenderState init() {
    return const RemoteKeyboardSenderState();
  }

  /// Connect to a remote keyboard receiver
  Future<bool> connect(String ip, int port) async {
    if (state.isConnected) {
      _logger.info('Already connected to a remote keyboard receiver');
      return true;
    }

    try {
      final wsUrl = 'ws://$ip:$port/keyboard/ws';
      _logger.info('Connecting to remote keyboard at $wsUrl');

      _socket = await WebSocket.connect(wsUrl).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('Connection timeout');
        },
      );

      _subscription = _socket!.listen(
        _handleMessage,
        onDone: () {
          _logger.info('Disconnected from remote keyboard');
          _handleDisconnect();
        },
        onError: (error) {
          _logger.warning('WebSocket error: $error');
          _handleDisconnect();
        },
      );

      // Register this device with the receiver
      final deviceInfo = ref.read(deviceFullInfoProvider);
      final settings = ref.read(settingsProvider);
      
      _socket!.add(jsonEncode({
        'type': 'register',
        'alias': settings.alias,
        'ip': deviceInfo.ip,
        'port': settings.port,
        'deviceId': deviceInfo.fingerprint,
      }));

      state = state.copyWith(
        isConnected: true,
        targetIp: ip,
        targetPort: port,
      );

      return true;
    } catch (e) {
      _logger.severe('Failed to connect to remote keyboard: $e');
      return false;
    }
  }

  void _handleMessage(dynamic data) {
    try {
      final json = jsonDecode(data as String) as Map<String, dynamic>;
      final type = json['type'] as String?;

      if (type == 'connected') {
        final receiverAlias = json['receiverAlias'] as String?;
        state = state.copyWith(targetAlias: receiverAlias);
        onConnectionChanged?.call(true, receiverAlias);
        _logger.info('Connected to receiver: $receiverAlias');
      }
    } catch (e) {
      _logger.warning('Failed to parse message: $e');
    }
  }

  void _handleDisconnect() {
    _subscription?.cancel();
    _subscription = null;
    _socket = null;
    
    state = const RemoteKeyboardSenderState();
    onConnectionChanged?.call(false, null);
  }

  /// Send text input to the connected receiver
  void sendText(String text) {
    if (!state.isConnected || _socket == null) {
      _logger.warning('Not connected to any receiver');
      return;
    }

    final settings = ref.read(settingsProvider);
    
    _socket!.add(jsonEncode({
      'type': 'keyboard_input',
      'inputType': 'text',
      'content': text,
      'senderAlias': settings.alias,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }));

    state = state.copyWith(
      currentText: text,
      lastSentAt: DateTime.now(),
    );
  }

  /// Send paste content to the connected receiver
  void sendPaste(String content) {
    if (!state.isConnected || _socket == null) {
      _logger.warning('Not connected to any receiver');
      return;
    }

    final settings = ref.read(settingsProvider);
    
    _socket!.add(jsonEncode({
      'type': 'keyboard_input',
      'inputType': 'paste',
      'content': content,
      'senderAlias': settings.alias,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }));

    state = state.copyWith(lastSentAt: DateTime.now());
  }

  /// Send backspace to the connected receiver
  void sendBackspace() {
    if (!state.isConnected || _socket == null) {
      _logger.warning('Not connected to any receiver');
      return;
    }

    final settings = ref.read(settingsProvider);
    
    _socket!.add(jsonEncode({
      'type': 'keyboard_input',
      'inputType': 'backspace',
      'senderAlias': settings.alias,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }));
  }

  /// Send enter to the connected receiver
  void sendEnter() {
    if (!state.isConnected || _socket == null) {
      _logger.warning('Not connected to any receiver');
      return;
    }

    final settings = ref.read(settingsProvider);
    
    _socket!.add(jsonEncode({
      'type': 'keyboard_input',
      'inputType': 'enter',
      'senderAlias': settings.alias,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }));
  }

  /// Send clear to the connected receiver
  void sendClear() {
    if (!state.isConnected || _socket == null) {
      _logger.warning('Not connected to any receiver');
      return;
    }

    final settings = ref.read(settingsProvider);
    
    _socket!.add(jsonEncode({
      'type': 'keyboard_input',
      'inputType': 'clear',
      'senderAlias': settings.alias,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }));
  }

  /// Disconnect from the remote keyboard receiver
  Future<void> disconnect() async {
    _logger.info('Disconnecting from remote keyboard');
    
    _reconnectTimer?.cancel();
    await _subscription?.cancel();
    await _socket?.close();
    
    _socket = null;
    _subscription = null;
    
    state = const RemoteKeyboardSenderState();
    onConnectionChanged?.call(false, null);
  }

  /// Scan for remote keyboard receivers on the local network
  Future<List<Map<String, dynamic>>> scanForReceivers({
    required List<String> localIps,
    int port = 53318,
  }) async {
    final receivers = <Map<String, dynamic>>[];
    
    for (final localIp in localIps) {
      // Extract subnet from local IP
      final parts = localIp.split('.');
      if (parts.length != 4) continue;
      
      final subnet = '${parts[0]}.${parts[1]}.${parts[2]}';
      
      // Scan the subnet
      final futures = <Future<void>>[];
      for (int i = 1; i <= 254; i++) {
        final targetIp = '$subnet.$i';
        if (targetIp == localIp) continue;
        
        futures.add(_pingReceiver(targetIp, port, receivers));
      }
      
      // Wait for all scans to complete (with timeout)
      await Future.wait(futures).timeout(
        const Duration(seconds: 3),
        onTimeout: () => [],
      );
    }
    
    return receivers;
  }

  Future<void> _pingReceiver(String ip, int port, List<Map<String, dynamic>> receivers) async {
    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(milliseconds: 500);
      
      final request = await client.get(ip, port, '/keyboard/ping');
      final response = await request.close().timeout(const Duration(milliseconds: 500));
      
      if (response.statusCode == 200) {
        final body = await response.transform(utf8.decoder).join();
        final data = jsonDecode(body) as Map<String, dynamic>;
        data['ip'] = ip;
        data['port'] = port;
        receivers.add(data);
      }
      
      client.close();
    } catch (e) {
      // Ignore connection errors (expected for most IPs)
    }
  }
}
