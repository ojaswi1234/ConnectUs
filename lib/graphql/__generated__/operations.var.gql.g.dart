// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GFetchChatHistoryVars> _$gFetchChatHistoryVarsSerializer =
    new _$GFetchChatHistoryVarsSerializer();
Serializer<GsendMessageVars> _$gsendMessageVarsSerializer =
    new _$GsendMessageVarsSerializer();
Serializer<GListenToChatVars> _$gListenToChatVarsSerializer =
    new _$GListenToChatVarsSerializer();
Serializer<GSearchUsersVars> _$gSearchUsersVarsSerializer =
    new _$GSearchUsersVarsSerializer();
Serializer<GSendCallSignalVars> _$gSendCallSignalVarsSerializer =
    new _$GSendCallSignalVarsSerializer();
Serializer<GListenToCallSignalsVars> _$gListenToCallSignalsVarsSerializer =
    new _$GListenToCallSignalsVarsSerializer();
Serializer<GAskAssistantVars> _$gAskAssistantVarsSerializer =
    new _$GAskAssistantVarsSerializer();

class _$GFetchChatHistoryVarsSerializer
    implements StructuredSerializer<GFetchChatHistoryVars> {
  @override
  final Iterable<Type> types = const [
    GFetchChatHistoryVars,
    _$GFetchChatHistoryVars
  ];
  @override
  final String wireName = 'GFetchChatHistoryVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GFetchChatHistoryVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.after;
    if (value != null) {
      result
        ..add('after')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GFetchChatHistoryVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GFetchChatHistoryVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'after':
          result.after = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GsendMessageVarsSerializer
    implements StructuredSerializer<GsendMessageVars> {
  @override
  final Iterable<Type> types = const [GsendMessageVars, _$GsendMessageVars];
  @override
  final String wireName = 'GsendMessageVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsendMessageVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GsendMessageVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsendMessageVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GListenToChatVarsSerializer
    implements StructuredSerializer<GListenToChatVars> {
  @override
  final Iterable<Type> types = const [GListenToChatVars, _$GListenToChatVars];
  @override
  final String wireName = 'GListenToChatVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GListenToChatVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GListenToChatVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GListenToChatVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchUsersVarsSerializer
    implements StructuredSerializer<GSearchUsersVars> {
  @override
  final Iterable<Type> types = const [GSearchUsersVars, _$GSearchUsersVars];
  @override
  final String wireName = 'GSearchUsersVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSearchUsersVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'query',
      serializers.serialize(object.query,
          specifiedType: const FullType(String)),
      'platform',
      serializers.serialize(object.platform,
          specifiedType: const FullType(_i2.GPlatform)),
    ];

    return result;
  }

  @override
  GSearchUsersVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchUsersVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'query':
          result.query = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'platform':
          result.platform = serializers.deserialize(value,
              specifiedType: const FullType(_i2.GPlatform))! as _i2.GPlatform;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendCallSignalVarsSerializer
    implements StructuredSerializer<GSendCallSignalVars> {
  @override
  final Iterable<Type> types = const [
    GSendCallSignalVars,
    _$GSendCallSignalVars
  ];
  @override
  final String wireName = 'GSendCallSignalVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSendCallSignalVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(_i2.GCallSignalType)),
      'payload',
      serializers.serialize(object.payload,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GSendCallSignalVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendCallSignalVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GCallSignalType))!
              as _i2.GCallSignalType;
          break;
        case 'payload':
          result.payload = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GListenToCallSignalsVarsSerializer
    implements StructuredSerializer<GListenToCallSignalsVars> {
  @override
  final Iterable<Type> types = const [
    GListenToCallSignalsVars,
    _$GListenToCallSignalsVars
  ];
  @override
  final String wireName = 'GListenToCallSignalsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GListenToCallSignalsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GListenToCallSignalsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GListenToCallSignalsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GAskAssistantVarsSerializer
    implements StructuredSerializer<GAskAssistantVars> {
  @override
  final Iterable<Type> types = const [GAskAssistantVars, _$GAskAssistantVars];
  @override
  final String wireName = 'GAskAssistantVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAskAssistantVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'prompt',
      serializers.serialize(object.prompt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GAskAssistantVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAskAssistantVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'prompt':
          result.prompt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GFetchChatHistoryVars extends GFetchChatHistoryVars {
  @override
  final String roomId;
  @override
  final String? after;

  factory _$GFetchChatHistoryVars(
          [void Function(GFetchChatHistoryVarsBuilder)? updates]) =>
      (new GFetchChatHistoryVarsBuilder()..update(updates))._build();

  _$GFetchChatHistoryVars._({required this.roomId, this.after}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GFetchChatHistoryVars', 'roomId');
  }

  @override
  GFetchChatHistoryVars rebuild(
          void Function(GFetchChatHistoryVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFetchChatHistoryVarsBuilder toBuilder() =>
      new GFetchChatHistoryVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFetchChatHistoryVars &&
        roomId == other.roomId &&
        after == other.after;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, after.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GFetchChatHistoryVars')
          ..add('roomId', roomId)
          ..add('after', after))
        .toString();
  }
}

class GFetchChatHistoryVarsBuilder
    implements Builder<GFetchChatHistoryVars, GFetchChatHistoryVarsBuilder> {
  _$GFetchChatHistoryVars? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _after;
  String? get after => _$this._after;
  set after(String? after) => _$this._after = after;

  GFetchChatHistoryVarsBuilder();

  GFetchChatHistoryVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _after = $v.after;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFetchChatHistoryVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFetchChatHistoryVars;
  }

  @override
  void update(void Function(GFetchChatHistoryVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFetchChatHistoryVars build() => _build();

  _$GFetchChatHistoryVars _build() {
    final _$result = _$v ??
        new _$GFetchChatHistoryVars._(
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GFetchChatHistoryVars', 'roomId'),
            after: after);
    replace(_$result);
    return _$result;
  }
}

class _$GsendMessageVars extends GsendMessageVars {
  @override
  final String roomId;
  @override
  final String user;
  @override
  final String text;

  factory _$GsendMessageVars(
          [void Function(GsendMessageVarsBuilder)? updates]) =>
      (new GsendMessageVarsBuilder()..update(updates))._build();

  _$GsendMessageVars._(
      {required this.roomId, required this.user, required this.text})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GsendMessageVars', 'roomId');
    BuiltValueNullFieldError.checkNotNull(user, r'GsendMessageVars', 'user');
    BuiltValueNullFieldError.checkNotNull(text, r'GsendMessageVars', 'text');
  }

  @override
  GsendMessageVars rebuild(void Function(GsendMessageVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsendMessageVarsBuilder toBuilder() =>
      new GsendMessageVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsendMessageVars &&
        roomId == other.roomId &&
        user == other.user &&
        text == other.text;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GsendMessageVars')
          ..add('roomId', roomId)
          ..add('user', user)
          ..add('text', text))
        .toString();
  }
}

class GsendMessageVarsBuilder
    implements Builder<GsendMessageVars, GsendMessageVarsBuilder> {
  _$GsendMessageVars? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  GsendMessageVarsBuilder();

  GsendMessageVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _user = $v.user;
      _text = $v.text;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsendMessageVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsendMessageVars;
  }

  @override
  void update(void Function(GsendMessageVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GsendMessageVars build() => _build();

  _$GsendMessageVars _build() {
    final _$result = _$v ??
        new _$GsendMessageVars._(
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GsendMessageVars', 'roomId'),
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GsendMessageVars', 'user'),
            text: BuiltValueNullFieldError.checkNotNull(
                text, r'GsendMessageVars', 'text'));
    replace(_$result);
    return _$result;
  }
}

class _$GListenToChatVars extends GListenToChatVars {
  @override
  final String roomId;

  factory _$GListenToChatVars(
          [void Function(GListenToChatVarsBuilder)? updates]) =>
      (new GListenToChatVarsBuilder()..update(updates))._build();

  _$GListenToChatVars._({required this.roomId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GListenToChatVars', 'roomId');
  }

  @override
  GListenToChatVars rebuild(void Function(GListenToChatVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListenToChatVarsBuilder toBuilder() =>
      new GListenToChatVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListenToChatVars && roomId == other.roomId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GListenToChatVars')
          ..add('roomId', roomId))
        .toString();
  }
}

class GListenToChatVarsBuilder
    implements Builder<GListenToChatVars, GListenToChatVarsBuilder> {
  _$GListenToChatVars? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  GListenToChatVarsBuilder();

  GListenToChatVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GListenToChatVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GListenToChatVars;
  }

  @override
  void update(void Function(GListenToChatVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GListenToChatVars build() => _build();

  _$GListenToChatVars _build() {
    final _$result = _$v ??
        new _$GListenToChatVars._(
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GListenToChatVars', 'roomId'));
    replace(_$result);
    return _$result;
  }
}

class _$GSearchUsersVars extends GSearchUsersVars {
  @override
  final String query;
  @override
  final _i2.GPlatform platform;

  factory _$GSearchUsersVars(
          [void Function(GSearchUsersVarsBuilder)? updates]) =>
      (new GSearchUsersVarsBuilder()..update(updates))._build();

  _$GSearchUsersVars._({required this.query, required this.platform})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(query, r'GSearchUsersVars', 'query');
    BuiltValueNullFieldError.checkNotNull(
        platform, r'GSearchUsersVars', 'platform');
  }

  @override
  GSearchUsersVars rebuild(void Function(GSearchUsersVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchUsersVarsBuilder toBuilder() =>
      new GSearchUsersVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchUsersVars &&
        query == other.query &&
        platform == other.platform;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, query.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchUsersVars')
          ..add('query', query)
          ..add('platform', platform))
        .toString();
  }
}

class GSearchUsersVarsBuilder
    implements Builder<GSearchUsersVars, GSearchUsersVarsBuilder> {
  _$GSearchUsersVars? _$v;

  String? _query;
  String? get query => _$this._query;
  set query(String? query) => _$this._query = query;

  _i2.GPlatform? _platform;
  _i2.GPlatform? get platform => _$this._platform;
  set platform(_i2.GPlatform? platform) => _$this._platform = platform;

  GSearchUsersVarsBuilder();

  GSearchUsersVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _query = $v.query;
      _platform = $v.platform;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchUsersVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchUsersVars;
  }

  @override
  void update(void Function(GSearchUsersVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchUsersVars build() => _build();

  _$GSearchUsersVars _build() {
    final _$result = _$v ??
        new _$GSearchUsersVars._(
            query: BuiltValueNullFieldError.checkNotNull(
                query, r'GSearchUsersVars', 'query'),
            platform: BuiltValueNullFieldError.checkNotNull(
                platform, r'GSearchUsersVars', 'platform'));
    replace(_$result);
    return _$result;
  }
}

class _$GSendCallSignalVars extends GSendCallSignalVars {
  @override
  final String roomId;
  @override
  final _i2.GCallSignalType type;
  @override
  final String payload;

  factory _$GSendCallSignalVars(
          [void Function(GSendCallSignalVarsBuilder)? updates]) =>
      (new GSendCallSignalVarsBuilder()..update(updates))._build();

  _$GSendCallSignalVars._(
      {required this.roomId, required this.type, required this.payload})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GSendCallSignalVars', 'roomId');
    BuiltValueNullFieldError.checkNotNull(type, r'GSendCallSignalVars', 'type');
    BuiltValueNullFieldError.checkNotNull(
        payload, r'GSendCallSignalVars', 'payload');
  }

  @override
  GSendCallSignalVars rebuild(
          void Function(GSendCallSignalVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendCallSignalVarsBuilder toBuilder() =>
      new GSendCallSignalVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendCallSignalVars &&
        roomId == other.roomId &&
        type == other.type &&
        payload == other.payload;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, payload.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendCallSignalVars')
          ..add('roomId', roomId)
          ..add('type', type)
          ..add('payload', payload))
        .toString();
  }
}

class GSendCallSignalVarsBuilder
    implements Builder<GSendCallSignalVars, GSendCallSignalVarsBuilder> {
  _$GSendCallSignalVars? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  _i2.GCallSignalType? _type;
  _i2.GCallSignalType? get type => _$this._type;
  set type(_i2.GCallSignalType? type) => _$this._type = type;

  String? _payload;
  String? get payload => _$this._payload;
  set payload(String? payload) => _$this._payload = payload;

  GSendCallSignalVarsBuilder();

  GSendCallSignalVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _type = $v.type;
      _payload = $v.payload;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendCallSignalVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendCallSignalVars;
  }

  @override
  void update(void Function(GSendCallSignalVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendCallSignalVars build() => _build();

  _$GSendCallSignalVars _build() {
    final _$result = _$v ??
        new _$GSendCallSignalVars._(
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GSendCallSignalVars', 'roomId'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'GSendCallSignalVars', 'type'),
            payload: BuiltValueNullFieldError.checkNotNull(
                payload, r'GSendCallSignalVars', 'payload'));
    replace(_$result);
    return _$result;
  }
}

class _$GListenToCallSignalsVars extends GListenToCallSignalsVars {
  @override
  final String roomId;

  factory _$GListenToCallSignalsVars(
          [void Function(GListenToCallSignalsVarsBuilder)? updates]) =>
      (new GListenToCallSignalsVarsBuilder()..update(updates))._build();

  _$GListenToCallSignalsVars._({required this.roomId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GListenToCallSignalsVars', 'roomId');
  }

  @override
  GListenToCallSignalsVars rebuild(
          void Function(GListenToCallSignalsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListenToCallSignalsVarsBuilder toBuilder() =>
      new GListenToCallSignalsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListenToCallSignalsVars && roomId == other.roomId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GListenToCallSignalsVars')
          ..add('roomId', roomId))
        .toString();
  }
}

class GListenToCallSignalsVarsBuilder
    implements
        Builder<GListenToCallSignalsVars, GListenToCallSignalsVarsBuilder> {
  _$GListenToCallSignalsVars? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  GListenToCallSignalsVarsBuilder();

  GListenToCallSignalsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GListenToCallSignalsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GListenToCallSignalsVars;
  }

  @override
  void update(void Function(GListenToCallSignalsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GListenToCallSignalsVars build() => _build();

  _$GListenToCallSignalsVars _build() {
    final _$result = _$v ??
        new _$GListenToCallSignalsVars._(
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GListenToCallSignalsVars', 'roomId'));
    replace(_$result);
    return _$result;
  }
}

class _$GAskAssistantVars extends GAskAssistantVars {
  @override
  final String prompt;

  factory _$GAskAssistantVars(
          [void Function(GAskAssistantVarsBuilder)? updates]) =>
      (new GAskAssistantVarsBuilder()..update(updates))._build();

  _$GAskAssistantVars._({required this.prompt}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        prompt, r'GAskAssistantVars', 'prompt');
  }

  @override
  GAskAssistantVars rebuild(void Function(GAskAssistantVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAskAssistantVarsBuilder toBuilder() =>
      new GAskAssistantVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAskAssistantVars && prompt == other.prompt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, prompt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAskAssistantVars')
          ..add('prompt', prompt))
        .toString();
  }
}

class GAskAssistantVarsBuilder
    implements Builder<GAskAssistantVars, GAskAssistantVarsBuilder> {
  _$GAskAssistantVars? _$v;

  String? _prompt;
  String? get prompt => _$this._prompt;
  set prompt(String? prompt) => _$this._prompt = prompt;

  GAskAssistantVarsBuilder();

  GAskAssistantVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _prompt = $v.prompt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAskAssistantVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAskAssistantVars;
  }

  @override
  void update(void Function(GAskAssistantVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAskAssistantVars build() => _build();

  _$GAskAssistantVars _build() {
    final _$result = _$v ??
        new _$GAskAssistantVars._(
            prompt: BuiltValueNullFieldError.checkNotNull(
                prompt, r'GAskAssistantVars', 'prompt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
