import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localsend_app/gen/strings.g.dart';
import 'package:localsend_app/provider/local_ip_provider.dart';
import 'package:localsend_app/provider/remote_keyboard_provider.dart';
import 'package:localsend_app/util/native/platform_check.dart';
import 'package:localsend_app/widget/custom_icon_button.dart';
import 'package:localsend_app/widget/responsive_list_view.dart';
import 'package:refena_flutter/refena_flutter.dart';

class RemoteKeyboardTab extends StatefulWidget {
  const RemoteKeyboardTab({super.key});

  @override
  State<RemoteKeyboardTab> createState() => _RemoteKeyboardTabState();
}

class _RemoteKeyboardTabState extends State<RemoteKeyboardTab> with Refena {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isScanning = false;
  List<Map<String, dynamic>> _discoveredReceivers = [];
  String _receivedText = '';
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    
    // Listen for received text on the receiver side
    ensureRef((ref) {
      final receiver = ref.notifier(remoteKeyboardReceiverProvider);
      receiver.onTextReceived = _handleReceivedText;
    });

    // Setup text controller listener for sending
    _textController.addListener(_onTextChanged);
  }

  void _handleReceivedText(String text) {
    setState(() {
      if (text == '\b') {
        // Backspace
        if (_receivedText.isNotEmpty) {
          _receivedText = _receivedText.substring(0, _receivedText.length - 1);
        }
      } else if (text == '\n') {
        // Enter
        _receivedText += '\n';
      } else if (text == '\x1b[2K') {
        // Clear
        _receivedText = '';
      } else {
        _receivedText += text;
      }
    });

    // Also copy to system clipboard
    Clipboard.setData(ClipboardData(text: _receivedText));
  }

  void _onTextChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      final sender = ref.notifier(remoteKeyboardSenderProvider);
      final text = _textController.text;
      if (text.isNotEmpty) {
        sender.sendText(text);
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _startReceiving() async {
    final receiver = ref.notifier(remoteKeyboardReceiverProvider);
    final success = await receiver.startListening();
    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to start keyboard receiver')),
      );
    }
  }

  Future<void> _stopReceiving() async {
    final receiver = ref.notifier(remoteKeyboardReceiverProvider);
    await receiver.stopListening();
  }

  Future<void> _scanForReceivers() async {
    setState(() {
      _isScanning = true;
      _discoveredReceivers = [];
    });

    final networkState = ref.read(localIpProvider);
    final sender = ref.notifier(remoteKeyboardSenderProvider);
    
    final receivers = await sender.scanForReceivers(localIps: networkState.localIps);
    
    setState(() {
      _isScanning = false;
      _discoveredReceivers = receivers;
    });
  }

  Future<void> _connectToReceiver(String ip, int port) async {
    final sender = ref.notifier(remoteKeyboardSenderProvider);
    final success = await sender.connect(ip, port);
    
    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to $ip:$port')),
      );
    }
  }

  Future<void> _disconnect() async {
    final sender = ref.notifier(remoteKeyboardSenderProvider);
    await sender.disconnect();
    _textController.clear();
  }

  Future<void> _connectManually() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.remoteKeyboard.enterAddress),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '192.168.1.100:53318',
          ),
          autofocus: true,
          keyboardType: TextInputType.text,
          onSubmitted: (value) => Navigator.of(context).pop(value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(t.general.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text(t.general.confirm),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      // Parse IP:port format
      final parts = result.split(':');
      final ip = parts[0];
      final port = parts.length > 1 ? int.tryParse(parts[1]) ?? 53318 : 53318;
      
      await _connectToReceiver(ip, port);
    }
  }

  Future<void> _pasteAndSend() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null && data!.text!.isNotEmpty) {
      final sender = ref.notifier(remoteKeyboardSenderProvider);
      sender.sendPaste(data.text!);
      
      // Also update the text field
      _textController.text = data.text!;
      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
    }
  }

  void _clearText() {
    _textController.clear();
    final sender = ref.notifier(remoteKeyboardSenderProvider);
    sender.sendClear();
  }

  Future<void> _copyReceivedText() async {
    await Clipboard.setData(ClipboardData(text: _receivedText));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.general.copiedToClipboard)),
      );
    }
  }

  void _clearReceivedText() {
    setState(() {
      _receivedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final receiverState = context.watch(remoteKeyboardReceiverProvider);
    final senderState = context.watch(remoteKeyboardSenderProvider);
    final networkState = context.watch(localIpProvider);
    final localIps = networkState.localIps;

    return Stack(
      children: [
        if (checkPlatform([TargetPlatform.macOS]))
          SizedBox(height: 50, child: MoveWindow()),
        ResponsiveListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
            
            // Receiver Section (for receiving keyboard input - Mac side)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          t.remoteKeyboard.receiver.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        if (receiverState.isListening)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              t.remoteKeyboard.receiver.listening,
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      t.remoteKeyboard.receiver.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Connection info when listening
                    if (receiverState.isListening) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${t.remoteKeyboard.receiver.address}:',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(height: 4),
                            ...localIps.map((ip) => Text(
                              '$ip:${receiverState.port}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontFamily: 'monospace',
                              ),
                            )),
                            if (receiverState.connectedDevices.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(
                                '${t.remoteKeyboard.receiver.connectedDevices}:',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(height: 4),
                              ...receiverState.connectedDevices.map((device) => Chip(
                                avatar: const Icon(Icons.computer, size: 18),
                                label: Text('${device.alias} (${device.ip})'),
                              )),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Received text display
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  t.remoteKeyboard.receiver.receivedText,
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.copy, size: 20),
                                  onPressed: _receivedText.isEmpty ? null : _copyReceivedText,
                                  tooltip: t.general.copy,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.clear, size: 20),
                                  onPressed: _receivedText.isEmpty ? null : _clearReceivedText,
                                  tooltip: t.general.clear,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(minHeight: 100),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: SelectableText(
                                _receivedText.isEmpty 
                                    ? t.remoteKeyboard.receiver.waitingForInput 
                                    : _receivedText,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  color: _receivedText.isEmpty 
                                      ? Theme.of(context).colorScheme.onSurfaceVariant 
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 16),
                    
                    // Start/Stop button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: receiverState.isListening ? _stopReceiving : _startReceiving,
                        icon: Icon(receiverState.isListening ? Icons.stop : Icons.play_arrow),
                        label: Text(receiverState.isListening 
                            ? t.remoteKeyboard.receiver.stop 
                            : t.remoteKeyboard.receiver.start),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: receiverState.isListening 
                              ? Theme.of(context).colorScheme.error 
                              : Theme.of(context).colorScheme.primary,
                          foregroundColor: receiverState.isListening 
                              ? Theme.of(context).colorScheme.onError 
                              : Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Sender Section (for sending keyboard input - Ubuntu side)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_up,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          t.remoteKeyboard.sender.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        if (senderState.isConnected)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              t.remoteKeyboard.sender.connected,
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      t.remoteKeyboard.sender.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    if (!senderState.isConnected) ...[
                      // Scan and connect section
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _isScanning ? null : _scanForReceivers,
                              icon: _isScanning 
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Icon(Icons.search),
                              label: Text(_isScanning 
                                  ? t.remoteKeyboard.sender.scanning 
                                  : t.remoteKeyboard.sender.scan),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: _connectManually,
                            icon: const Icon(Icons.add),
                            tooltip: t.remoteKeyboard.sender.manual,
                          ),
                        ],
                      ),
                      
                      if (_discoveredReceivers.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          t.remoteKeyboard.sender.discoveredDevices,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 8),
                        ...(_discoveredReceivers.map((receiver) => ListTile(
                          leading: const Icon(Icons.computer),
                          title: Text(receiver['alias'] as String? ?? 'Unknown'),
                          subtitle: Text('${receiver['ip']}:${receiver['port']}'),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () => _connectToReceiver(
                            receiver['ip'] as String,
                            receiver['port'] as int,
                          ),
                        ))),
                      ],
                    ] else ...[
                      // Connected state - show input field
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.link, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${t.remoteKeyboard.sender.connectedTo}: ${senderState.targetAlias ?? senderState.targetIp}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            TextButton(
                              onPressed: _disconnect,
                              child: Text(t.remoteKeyboard.sender.disconnect),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Text input field
                      TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: t.remoteKeyboard.sender.inputHint,
                          border: const OutlineInputBorder(),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.paste),
                                onPressed: _pasteAndSend,
                                tooltip: t.general.paste,
                              ),
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: _clearText,
                                tooltip: t.general.clear,
                              ),
                            ],
                          ),
                        ),
                        onChanged: (value) {
                          // Text is sent via the listener
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.remoteKeyboard.sender.inputDescription,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
