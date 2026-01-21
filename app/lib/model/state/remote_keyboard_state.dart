import 'package:dart_mappable/dart_mappable.dart';

part 'remote_keyboard_state.mapper.dart';

/// Represents a connected remote keyboard device
@MappableClass()
class RemoteKeyboardDevice with RemoteKeyboardDeviceMappable {
  final String id;
  final String alias;
  final String ip;
  final int port;
  final DateTime connectedAt;
  final bool isActive;

  const RemoteKeyboardDevice({
    required this.id,
    required this.alias,
    required this.ip,
    required this.port,
    required this.connectedAt,
    this.isActive = true,
  });
}

/// State for the remote keyboard receiver (Mac side)
@MappableClass()
class RemoteKeyboardReceiverState with RemoteKeyboardReceiverStateMappable {
  final bool isListening;
  final int port;
  final List<RemoteKeyboardDevice> connectedDevices;
  final String? lastReceivedText;
  final DateTime? lastReceivedAt;

  const RemoteKeyboardReceiverState({
    this.isListening = false,
    this.port = 53318,
    this.connectedDevices = const [],
    this.lastReceivedText,
    this.lastReceivedAt,
  });
}

/// State for the remote keyboard sender (Ubuntu side)
@MappableClass()
class RemoteKeyboardSenderState with RemoteKeyboardSenderStateMappable {
  final bool isConnected;
  final String? targetIp;
  final int? targetPort;
  final String? targetAlias;
  final String currentText;
  final DateTime? lastSentAt;

  const RemoteKeyboardSenderState({
    this.isConnected = false,
    this.targetIp,
    this.targetPort,
    this.targetAlias,
    this.currentText = '',
    this.lastSentAt,
  });
}

/// DTO for keyboard input messages
@MappableClass()
class KeyboardInputDto with KeyboardInputDtoMappable {
  final String type; // 'text', 'backspace', 'enter', 'clear', 'paste'
  final String? content;
  final String senderId;
  final String senderAlias;
  final int timestamp;

  const KeyboardInputDto({
    required this.type,
    this.content,
    required this.senderId,
    required this.senderAlias,
    required this.timestamp,
  });

  factory KeyboardInputDto.text(String content, String senderId, String senderAlias) {
    return KeyboardInputDto(
      type: 'text',
      content: content,
      senderId: senderId,
      senderAlias: senderAlias,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  factory KeyboardInputDto.backspace(String senderId, String senderAlias) {
    return KeyboardInputDto(
      type: 'backspace',
      senderId: senderId,
      senderAlias: senderAlias,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  factory KeyboardInputDto.enter(String senderId, String senderAlias) {
    return KeyboardInputDto(
      type: 'enter',
      senderId: senderId,
      senderAlias: senderAlias,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  factory KeyboardInputDto.clear(String senderId, String senderAlias) {
    return KeyboardInputDto(
      type: 'clear',
      senderId: senderId,
      senderAlias: senderAlias,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  factory KeyboardInputDto.paste(String content, String senderId, String senderAlias) {
    return KeyboardInputDto(
      type: 'paste',
      content: content,
      senderId: senderId,
      senderAlias: senderAlias,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }
}

/// Response when connecting to a remote keyboard receiver
@MappableClass()
class KeyboardConnectionResponse with KeyboardConnectionResponseMappable {
  final bool success;
  final String? message;
  final String? receiverAlias;

  const KeyboardConnectionResponse({
    required this.success,
    this.message,
    this.receiverAlias,
  });
}
