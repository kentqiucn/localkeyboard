// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'remote_keyboard_state.dart';

class RemoteKeyboardDeviceMapper extends ClassMapperBase<RemoteKeyboardDevice> {
  RemoteKeyboardDeviceMapper._();

  static RemoteKeyboardDeviceMapper? _instance;
  static RemoteKeyboardDeviceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteKeyboardDeviceMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteKeyboardDevice';

  static String _$id(RemoteKeyboardDevice v) => v.id;
  static const Field<RemoteKeyboardDevice, String> _f$id = Field('id', _$id);
  static String _$alias(RemoteKeyboardDevice v) => v.alias;
  static const Field<RemoteKeyboardDevice, String> _f$alias = Field(
    'alias',
    _$alias,
  );
  static String _$ip(RemoteKeyboardDevice v) => v.ip;
  static const Field<RemoteKeyboardDevice, String> _f$ip = Field('ip', _$ip);
  static int _$port(RemoteKeyboardDevice v) => v.port;
  static const Field<RemoteKeyboardDevice, int> _f$port = Field('port', _$port);
  static DateTime _$connectedAt(RemoteKeyboardDevice v) => v.connectedAt;
  static const Field<RemoteKeyboardDevice, DateTime> _f$connectedAt = Field(
    'connectedAt',
    _$connectedAt,
  );
  static bool _$isActive(RemoteKeyboardDevice v) => v.isActive;
  static const Field<RemoteKeyboardDevice, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<RemoteKeyboardDevice> fields = const {
    #id: _f$id,
    #alias: _f$alias,
    #ip: _f$ip,
    #port: _f$port,
    #connectedAt: _f$connectedAt,
    #isActive: _f$isActive,
  };

  static RemoteKeyboardDevice _instantiate(DecodingData data) {
    return RemoteKeyboardDevice(
      id: data.dec(_f$id),
      alias: data.dec(_f$alias),
      ip: data.dec(_f$ip),
      port: data.dec(_f$port),
      connectedAt: data.dec(_f$connectedAt),
      isActive: data.dec(_f$isActive),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteKeyboardDevice fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteKeyboardDevice>(map);
  }

  static RemoteKeyboardDevice deserialize(String json) {
    return ensureInitialized().decodeJson<RemoteKeyboardDevice>(json);
  }
}

mixin RemoteKeyboardDeviceMappable {
  String serialize() {
    return RemoteKeyboardDeviceMapper.ensureInitialized()
        .encodeJson<RemoteKeyboardDevice>(this as RemoteKeyboardDevice);
  }

  Map<String, dynamic> toJson() {
    return RemoteKeyboardDeviceMapper.ensureInitialized()
        .encodeMap<RemoteKeyboardDevice>(this as RemoteKeyboardDevice);
  }

  RemoteKeyboardDeviceCopyWith<
    RemoteKeyboardDevice,
    RemoteKeyboardDevice,
    RemoteKeyboardDevice
  >
  get copyWith =>
      _RemoteKeyboardDeviceCopyWithImpl<
        RemoteKeyboardDevice,
        RemoteKeyboardDevice
      >(this as RemoteKeyboardDevice, $identity, $identity);
  @override
  String toString() {
    return RemoteKeyboardDeviceMapper.ensureInitialized().stringifyValue(
      this as RemoteKeyboardDevice,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteKeyboardDeviceMapper.ensureInitialized().equalsValue(
      this as RemoteKeyboardDevice,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteKeyboardDeviceMapper.ensureInitialized().hashValue(
      this as RemoteKeyboardDevice,
    );
  }
}

extension RemoteKeyboardDeviceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteKeyboardDevice, $Out> {
  RemoteKeyboardDeviceCopyWith<$R, RemoteKeyboardDevice, $Out>
  get $asRemoteKeyboardDevice => $base.as(
    (v, t, t2) => _RemoteKeyboardDeviceCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RemoteKeyboardDeviceCopyWith<
  $R,
  $In extends RemoteKeyboardDevice,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? alias,
    String? ip,
    int? port,
    DateTime? connectedAt,
    bool? isActive,
  });
  RemoteKeyboardDeviceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteKeyboardDeviceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteKeyboardDevice, $Out>
    implements RemoteKeyboardDeviceCopyWith<$R, RemoteKeyboardDevice, $Out> {
  _RemoteKeyboardDeviceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteKeyboardDevice> $mapper =
      RemoteKeyboardDeviceMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? alias,
    String? ip,
    int? port,
    DateTime? connectedAt,
    bool? isActive,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (alias != null) #alias: alias,
      if (ip != null) #ip: ip,
      if (port != null) #port: port,
      if (connectedAt != null) #connectedAt: connectedAt,
      if (isActive != null) #isActive: isActive,
    }),
  );
  @override
  RemoteKeyboardDevice $make(CopyWithData data) => RemoteKeyboardDevice(
    id: data.get(#id, or: $value.id),
    alias: data.get(#alias, or: $value.alias),
    ip: data.get(#ip, or: $value.ip),
    port: data.get(#port, or: $value.port),
    connectedAt: data.get(#connectedAt, or: $value.connectedAt),
    isActive: data.get(#isActive, or: $value.isActive),
  );

  @override
  RemoteKeyboardDeviceCopyWith<$R2, RemoteKeyboardDevice, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RemoteKeyboardDeviceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoteKeyboardReceiverStateMapper
    extends ClassMapperBase<RemoteKeyboardReceiverState> {
  RemoteKeyboardReceiverStateMapper._();

  static RemoteKeyboardReceiverStateMapper? _instance;
  static RemoteKeyboardReceiverStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = RemoteKeyboardReceiverStateMapper._(),
      );
      RemoteKeyboardDeviceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteKeyboardReceiverState';

  static bool _$isListening(RemoteKeyboardReceiverState v) => v.isListening;
  static const Field<RemoteKeyboardReceiverState, bool> _f$isListening = Field(
    'isListening',
    _$isListening,
    opt: true,
    def: false,
  );
  static int _$port(RemoteKeyboardReceiverState v) => v.port;
  static const Field<RemoteKeyboardReceiverState, int> _f$port = Field(
    'port',
    _$port,
    opt: true,
    def: 53318,
  );
  static List<RemoteKeyboardDevice> _$connectedDevices(
    RemoteKeyboardReceiverState v,
  ) => v.connectedDevices;
  static const Field<RemoteKeyboardReceiverState, List<RemoteKeyboardDevice>>
  _f$connectedDevices = Field(
    'connectedDevices',
    _$connectedDevices,
    opt: true,
    def: const [],
  );
  static String? _$lastReceivedText(RemoteKeyboardReceiverState v) =>
      v.lastReceivedText;
  static const Field<RemoteKeyboardReceiverState, String> _f$lastReceivedText =
      Field('lastReceivedText', _$lastReceivedText, opt: true);
  static DateTime? _$lastReceivedAt(RemoteKeyboardReceiverState v) =>
      v.lastReceivedAt;
  static const Field<RemoteKeyboardReceiverState, DateTime> _f$lastReceivedAt =
      Field('lastReceivedAt', _$lastReceivedAt, opt: true);

  @override
  final MappableFields<RemoteKeyboardReceiverState> fields = const {
    #isListening: _f$isListening,
    #port: _f$port,
    #connectedDevices: _f$connectedDevices,
    #lastReceivedText: _f$lastReceivedText,
    #lastReceivedAt: _f$lastReceivedAt,
  };

  static RemoteKeyboardReceiverState _instantiate(DecodingData data) {
    return RemoteKeyboardReceiverState(
      isListening: data.dec(_f$isListening),
      port: data.dec(_f$port),
      connectedDevices: data.dec(_f$connectedDevices),
      lastReceivedText: data.dec(_f$lastReceivedText),
      lastReceivedAt: data.dec(_f$lastReceivedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteKeyboardReceiverState fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteKeyboardReceiverState>(map);
  }

  static RemoteKeyboardReceiverState deserialize(String json) {
    return ensureInitialized().decodeJson<RemoteKeyboardReceiverState>(json);
  }
}

mixin RemoteKeyboardReceiverStateMappable {
  String serialize() {
    return RemoteKeyboardReceiverStateMapper.ensureInitialized()
        .encodeJson<RemoteKeyboardReceiverState>(
          this as RemoteKeyboardReceiverState,
        );
  }

  Map<String, dynamic> toJson() {
    return RemoteKeyboardReceiverStateMapper.ensureInitialized()
        .encodeMap<RemoteKeyboardReceiverState>(
          this as RemoteKeyboardReceiverState,
        );
  }

  RemoteKeyboardReceiverStateCopyWith<
    RemoteKeyboardReceiverState,
    RemoteKeyboardReceiverState,
    RemoteKeyboardReceiverState
  >
  get copyWith =>
      _RemoteKeyboardReceiverStateCopyWithImpl<
        RemoteKeyboardReceiverState,
        RemoteKeyboardReceiverState
      >(this as RemoteKeyboardReceiverState, $identity, $identity);
  @override
  String toString() {
    return RemoteKeyboardReceiverStateMapper.ensureInitialized().stringifyValue(
      this as RemoteKeyboardReceiverState,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteKeyboardReceiverStateMapper.ensureInitialized().equalsValue(
      this as RemoteKeyboardReceiverState,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteKeyboardReceiverStateMapper.ensureInitialized().hashValue(
      this as RemoteKeyboardReceiverState,
    );
  }
}

extension RemoteKeyboardReceiverStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteKeyboardReceiverState, $Out> {
  RemoteKeyboardReceiverStateCopyWith<$R, RemoteKeyboardReceiverState, $Out>
  get $asRemoteKeyboardReceiverState => $base.as(
    (v, t, t2) => _RemoteKeyboardReceiverStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RemoteKeyboardReceiverStateCopyWith<
  $R,
  $In extends RemoteKeyboardReceiverState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    RemoteKeyboardDevice,
    RemoteKeyboardDeviceCopyWith<$R, RemoteKeyboardDevice, RemoteKeyboardDevice>
  >
  get connectedDevices;
  $R call({
    bool? isListening,
    int? port,
    List<RemoteKeyboardDevice>? connectedDevices,
    String? lastReceivedText,
    DateTime? lastReceivedAt,
  });
  RemoteKeyboardReceiverStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteKeyboardReceiverStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteKeyboardReceiverState, $Out>
    implements
        RemoteKeyboardReceiverStateCopyWith<
          $R,
          RemoteKeyboardReceiverState,
          $Out
        > {
  _RemoteKeyboardReceiverStateCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<RemoteKeyboardReceiverState> $mapper =
      RemoteKeyboardReceiverStateMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    RemoteKeyboardDevice,
    RemoteKeyboardDeviceCopyWith<$R, RemoteKeyboardDevice, RemoteKeyboardDevice>
  >
  get connectedDevices => ListCopyWith(
    $value.connectedDevices,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(connectedDevices: v),
  );
  @override
  $R call({
    bool? isListening,
    int? port,
    List<RemoteKeyboardDevice>? connectedDevices,
    Object? lastReceivedText = $none,
    Object? lastReceivedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (isListening != null) #isListening: isListening,
      if (port != null) #port: port,
      if (connectedDevices != null) #connectedDevices: connectedDevices,
      if (lastReceivedText != $none) #lastReceivedText: lastReceivedText,
      if (lastReceivedAt != $none) #lastReceivedAt: lastReceivedAt,
    }),
  );
  @override
  RemoteKeyboardReceiverState $make(
    CopyWithData data,
  ) => RemoteKeyboardReceiverState(
    isListening: data.get(#isListening, or: $value.isListening),
    port: data.get(#port, or: $value.port),
    connectedDevices: data.get(#connectedDevices, or: $value.connectedDevices),
    lastReceivedText: data.get(#lastReceivedText, or: $value.lastReceivedText),
    lastReceivedAt: data.get(#lastReceivedAt, or: $value.lastReceivedAt),
  );

  @override
  RemoteKeyboardReceiverStateCopyWith<$R2, RemoteKeyboardReceiverState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RemoteKeyboardReceiverStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RemoteKeyboardSenderStateMapper
    extends ClassMapperBase<RemoteKeyboardSenderState> {
  RemoteKeyboardSenderStateMapper._();

  static RemoteKeyboardSenderStateMapper? _instance;
  static RemoteKeyboardSenderStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = RemoteKeyboardSenderStateMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteKeyboardSenderState';

  static bool _$isConnected(RemoteKeyboardSenderState v) => v.isConnected;
  static const Field<RemoteKeyboardSenderState, bool> _f$isConnected = Field(
    'isConnected',
    _$isConnected,
    opt: true,
    def: false,
  );
  static String? _$targetIp(RemoteKeyboardSenderState v) => v.targetIp;
  static const Field<RemoteKeyboardSenderState, String> _f$targetIp = Field(
    'targetIp',
    _$targetIp,
    opt: true,
  );
  static int? _$targetPort(RemoteKeyboardSenderState v) => v.targetPort;
  static const Field<RemoteKeyboardSenderState, int> _f$targetPort = Field(
    'targetPort',
    _$targetPort,
    opt: true,
  );
  static String? _$targetAlias(RemoteKeyboardSenderState v) => v.targetAlias;
  static const Field<RemoteKeyboardSenderState, String> _f$targetAlias = Field(
    'targetAlias',
    _$targetAlias,
    opt: true,
  );
  static String _$currentText(RemoteKeyboardSenderState v) => v.currentText;
  static const Field<RemoteKeyboardSenderState, String> _f$currentText = Field(
    'currentText',
    _$currentText,
    opt: true,
    def: '',
  );
  static DateTime? _$lastSentAt(RemoteKeyboardSenderState v) => v.lastSentAt;
  static const Field<RemoteKeyboardSenderState, DateTime> _f$lastSentAt = Field(
    'lastSentAt',
    _$lastSentAt,
    opt: true,
  );

  @override
  final MappableFields<RemoteKeyboardSenderState> fields = const {
    #isConnected: _f$isConnected,
    #targetIp: _f$targetIp,
    #targetPort: _f$targetPort,
    #targetAlias: _f$targetAlias,
    #currentText: _f$currentText,
    #lastSentAt: _f$lastSentAt,
  };

  static RemoteKeyboardSenderState _instantiate(DecodingData data) {
    return RemoteKeyboardSenderState(
      isConnected: data.dec(_f$isConnected),
      targetIp: data.dec(_f$targetIp),
      targetPort: data.dec(_f$targetPort),
      targetAlias: data.dec(_f$targetAlias),
      currentText: data.dec(_f$currentText),
      lastSentAt: data.dec(_f$lastSentAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteKeyboardSenderState fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteKeyboardSenderState>(map);
  }

  static RemoteKeyboardSenderState deserialize(String json) {
    return ensureInitialized().decodeJson<RemoteKeyboardSenderState>(json);
  }
}

mixin RemoteKeyboardSenderStateMappable {
  String serialize() {
    return RemoteKeyboardSenderStateMapper.ensureInitialized()
        .encodeJson<RemoteKeyboardSenderState>(
          this as RemoteKeyboardSenderState,
        );
  }

  Map<String, dynamic> toJson() {
    return RemoteKeyboardSenderStateMapper.ensureInitialized()
        .encodeMap<RemoteKeyboardSenderState>(
          this as RemoteKeyboardSenderState,
        );
  }

  RemoteKeyboardSenderStateCopyWith<
    RemoteKeyboardSenderState,
    RemoteKeyboardSenderState,
    RemoteKeyboardSenderState
  >
  get copyWith =>
      _RemoteKeyboardSenderStateCopyWithImpl<
        RemoteKeyboardSenderState,
        RemoteKeyboardSenderState
      >(this as RemoteKeyboardSenderState, $identity, $identity);
  @override
  String toString() {
    return RemoteKeyboardSenderStateMapper.ensureInitialized().stringifyValue(
      this as RemoteKeyboardSenderState,
    );
  }

  @override
  bool operator ==(Object other) {
    return RemoteKeyboardSenderStateMapper.ensureInitialized().equalsValue(
      this as RemoteKeyboardSenderState,
      other,
    );
  }

  @override
  int get hashCode {
    return RemoteKeyboardSenderStateMapper.ensureInitialized().hashValue(
      this as RemoteKeyboardSenderState,
    );
  }
}

extension RemoteKeyboardSenderStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteKeyboardSenderState, $Out> {
  RemoteKeyboardSenderStateCopyWith<$R, RemoteKeyboardSenderState, $Out>
  get $asRemoteKeyboardSenderState => $base.as(
    (v, t, t2) => _RemoteKeyboardSenderStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RemoteKeyboardSenderStateCopyWith<
  $R,
  $In extends RemoteKeyboardSenderState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    bool? isConnected,
    String? targetIp,
    int? targetPort,
    String? targetAlias,
    String? currentText,
    DateTime? lastSentAt,
  });
  RemoteKeyboardSenderStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RemoteKeyboardSenderStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteKeyboardSenderState, $Out>
    implements
        RemoteKeyboardSenderStateCopyWith<$R, RemoteKeyboardSenderState, $Out> {
  _RemoteKeyboardSenderStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteKeyboardSenderState> $mapper =
      RemoteKeyboardSenderStateMapper.ensureInitialized();
  @override
  $R call({
    bool? isConnected,
    Object? targetIp = $none,
    Object? targetPort = $none,
    Object? targetAlias = $none,
    String? currentText,
    Object? lastSentAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (isConnected != null) #isConnected: isConnected,
      if (targetIp != $none) #targetIp: targetIp,
      if (targetPort != $none) #targetPort: targetPort,
      if (targetAlias != $none) #targetAlias: targetAlias,
      if (currentText != null) #currentText: currentText,
      if (lastSentAt != $none) #lastSentAt: lastSentAt,
    }),
  );
  @override
  RemoteKeyboardSenderState $make(CopyWithData data) =>
      RemoteKeyboardSenderState(
        isConnected: data.get(#isConnected, or: $value.isConnected),
        targetIp: data.get(#targetIp, or: $value.targetIp),
        targetPort: data.get(#targetPort, or: $value.targetPort),
        targetAlias: data.get(#targetAlias, or: $value.targetAlias),
        currentText: data.get(#currentText, or: $value.currentText),
        lastSentAt: data.get(#lastSentAt, or: $value.lastSentAt),
      );

  @override
  RemoteKeyboardSenderStateCopyWith<$R2, RemoteKeyboardSenderState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RemoteKeyboardSenderStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class KeyboardInputDtoMapper extends ClassMapperBase<KeyboardInputDto> {
  KeyboardInputDtoMapper._();

  static KeyboardInputDtoMapper? _instance;
  static KeyboardInputDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = KeyboardInputDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'KeyboardInputDto';

  static String _$type(KeyboardInputDto v) => v.type;
  static const Field<KeyboardInputDto, String> _f$type = Field('type', _$type);
  static String? _$content(KeyboardInputDto v) => v.content;
  static const Field<KeyboardInputDto, String> _f$content = Field(
    'content',
    _$content,
    opt: true,
  );
  static String _$senderId(KeyboardInputDto v) => v.senderId;
  static const Field<KeyboardInputDto, String> _f$senderId = Field(
    'senderId',
    _$senderId,
  );
  static String _$senderAlias(KeyboardInputDto v) => v.senderAlias;
  static const Field<KeyboardInputDto, String> _f$senderAlias = Field(
    'senderAlias',
    _$senderAlias,
  );
  static int _$timestamp(KeyboardInputDto v) => v.timestamp;
  static const Field<KeyboardInputDto, int> _f$timestamp = Field(
    'timestamp',
    _$timestamp,
  );

  @override
  final MappableFields<KeyboardInputDto> fields = const {
    #type: _f$type,
    #content: _f$content,
    #senderId: _f$senderId,
    #senderAlias: _f$senderAlias,
    #timestamp: _f$timestamp,
  };

  static KeyboardInputDto _instantiate(DecodingData data) {
    return KeyboardInputDto(
      type: data.dec(_f$type),
      content: data.dec(_f$content),
      senderId: data.dec(_f$senderId),
      senderAlias: data.dec(_f$senderAlias),
      timestamp: data.dec(_f$timestamp),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static KeyboardInputDto fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<KeyboardInputDto>(map);
  }

  static KeyboardInputDto deserialize(String json) {
    return ensureInitialized().decodeJson<KeyboardInputDto>(json);
  }
}

mixin KeyboardInputDtoMappable {
  String serialize() {
    return KeyboardInputDtoMapper.ensureInitialized()
        .encodeJson<KeyboardInputDto>(this as KeyboardInputDto);
  }

  Map<String, dynamic> toJson() {
    return KeyboardInputDtoMapper.ensureInitialized()
        .encodeMap<KeyboardInputDto>(this as KeyboardInputDto);
  }

  KeyboardInputDtoCopyWith<KeyboardInputDto, KeyboardInputDto, KeyboardInputDto>
  get copyWith =>
      _KeyboardInputDtoCopyWithImpl<KeyboardInputDto, KeyboardInputDto>(
        this as KeyboardInputDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return KeyboardInputDtoMapper.ensureInitialized().stringifyValue(
      this as KeyboardInputDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return KeyboardInputDtoMapper.ensureInitialized().equalsValue(
      this as KeyboardInputDto,
      other,
    );
  }

  @override
  int get hashCode {
    return KeyboardInputDtoMapper.ensureInitialized().hashValue(
      this as KeyboardInputDto,
    );
  }
}

extension KeyboardInputDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, KeyboardInputDto, $Out> {
  KeyboardInputDtoCopyWith<$R, KeyboardInputDto, $Out>
  get $asKeyboardInputDto =>
      $base.as((v, t, t2) => _KeyboardInputDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class KeyboardInputDtoCopyWith<$R, $In extends KeyboardInputDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? type,
    String? content,
    String? senderId,
    String? senderAlias,
    int? timestamp,
  });
  KeyboardInputDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _KeyboardInputDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, KeyboardInputDto, $Out>
    implements KeyboardInputDtoCopyWith<$R, KeyboardInputDto, $Out> {
  _KeyboardInputDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<KeyboardInputDto> $mapper =
      KeyboardInputDtoMapper.ensureInitialized();
  @override
  $R call({
    String? type,
    Object? content = $none,
    String? senderId,
    String? senderAlias,
    int? timestamp,
  }) => $apply(
    FieldCopyWithData({
      if (type != null) #type: type,
      if (content != $none) #content: content,
      if (senderId != null) #senderId: senderId,
      if (senderAlias != null) #senderAlias: senderAlias,
      if (timestamp != null) #timestamp: timestamp,
    }),
  );
  @override
  KeyboardInputDto $make(CopyWithData data) => KeyboardInputDto(
    type: data.get(#type, or: $value.type),
    content: data.get(#content, or: $value.content),
    senderId: data.get(#senderId, or: $value.senderId),
    senderAlias: data.get(#senderAlias, or: $value.senderAlias),
    timestamp: data.get(#timestamp, or: $value.timestamp),
  );

  @override
  KeyboardInputDtoCopyWith<$R2, KeyboardInputDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _KeyboardInputDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class KeyboardConnectionResponseMapper
    extends ClassMapperBase<KeyboardConnectionResponse> {
  KeyboardConnectionResponseMapper._();

  static KeyboardConnectionResponseMapper? _instance;
  static KeyboardConnectionResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = KeyboardConnectionResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'KeyboardConnectionResponse';

  static bool _$success(KeyboardConnectionResponse v) => v.success;
  static const Field<KeyboardConnectionResponse, bool> _f$success = Field(
    'success',
    _$success,
  );
  static String? _$message(KeyboardConnectionResponse v) => v.message;
  static const Field<KeyboardConnectionResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static String? _$receiverAlias(KeyboardConnectionResponse v) =>
      v.receiverAlias;
  static const Field<KeyboardConnectionResponse, String> _f$receiverAlias =
      Field('receiverAlias', _$receiverAlias, opt: true);

  @override
  final MappableFields<KeyboardConnectionResponse> fields = const {
    #success: _f$success,
    #message: _f$message,
    #receiverAlias: _f$receiverAlias,
  };

  static KeyboardConnectionResponse _instantiate(DecodingData data) {
    return KeyboardConnectionResponse(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      receiverAlias: data.dec(_f$receiverAlias),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static KeyboardConnectionResponse fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<KeyboardConnectionResponse>(map);
  }

  static KeyboardConnectionResponse deserialize(String json) {
    return ensureInitialized().decodeJson<KeyboardConnectionResponse>(json);
  }
}

mixin KeyboardConnectionResponseMappable {
  String serialize() {
    return KeyboardConnectionResponseMapper.ensureInitialized()
        .encodeJson<KeyboardConnectionResponse>(
          this as KeyboardConnectionResponse,
        );
  }

  Map<String, dynamic> toJson() {
    return KeyboardConnectionResponseMapper.ensureInitialized()
        .encodeMap<KeyboardConnectionResponse>(
          this as KeyboardConnectionResponse,
        );
  }

  KeyboardConnectionResponseCopyWith<
    KeyboardConnectionResponse,
    KeyboardConnectionResponse,
    KeyboardConnectionResponse
  >
  get copyWith =>
      _KeyboardConnectionResponseCopyWithImpl<
        KeyboardConnectionResponse,
        KeyboardConnectionResponse
      >(this as KeyboardConnectionResponse, $identity, $identity);
  @override
  String toString() {
    return KeyboardConnectionResponseMapper.ensureInitialized().stringifyValue(
      this as KeyboardConnectionResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return KeyboardConnectionResponseMapper.ensureInitialized().equalsValue(
      this as KeyboardConnectionResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return KeyboardConnectionResponseMapper.ensureInitialized().hashValue(
      this as KeyboardConnectionResponse,
    );
  }
}

extension KeyboardConnectionResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, KeyboardConnectionResponse, $Out> {
  KeyboardConnectionResponseCopyWith<$R, KeyboardConnectionResponse, $Out>
  get $asKeyboardConnectionResponse => $base.as(
    (v, t, t2) => _KeyboardConnectionResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class KeyboardConnectionResponseCopyWith<
  $R,
  $In extends KeyboardConnectionResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? success, String? message, String? receiverAlias});
  KeyboardConnectionResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _KeyboardConnectionResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, KeyboardConnectionResponse, $Out>
    implements
        KeyboardConnectionResponseCopyWith<
          $R,
          KeyboardConnectionResponse,
          $Out
        > {
  _KeyboardConnectionResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<KeyboardConnectionResponse> $mapper =
      KeyboardConnectionResponseMapper.ensureInitialized();
  @override
  $R call({
    bool? success,
    Object? message = $none,
    Object? receiverAlias = $none,
  }) => $apply(
    FieldCopyWithData({
      if (success != null) #success: success,
      if (message != $none) #message: message,
      if (receiverAlias != $none) #receiverAlias: receiverAlias,
    }),
  );
  @override
  KeyboardConnectionResponse $make(CopyWithData data) =>
      KeyboardConnectionResponse(
        success: data.get(#success, or: $value.success),
        message: data.get(#message, or: $value.message),
        receiverAlias: data.get(#receiverAlias, or: $value.receiverAlias),
      );

  @override
  KeyboardConnectionResponseCopyWith<$R2, KeyboardConnectionResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _KeyboardConnectionResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

