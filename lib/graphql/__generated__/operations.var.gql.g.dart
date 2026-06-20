// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetMessagesVars> _$gGetMessagesVarsSerializer =
    new _$GGetMessagesVarsSerializer();
Serializer<GSendMessageVars> _$gSendMessageVarsSerializer =
    new _$GSendMessageVarsSerializer();
Serializer<GListenToChatVars> _$gListenToChatVarsSerializer =
    new _$GListenToChatVarsSerializer();

class _$GGetMessagesVarsSerializer
    implements StructuredSerializer<GGetMessagesVars> {
  @override
  final Iterable<Type> types = const [GGetMessagesVars, _$GGetMessagesVars];
  @override
  final String wireName = 'GGetMessagesVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetMessagesVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetMessagesVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetMessagesVarsBuilder();

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

class _$GSendMessageVarsSerializer
    implements StructuredSerializer<GSendMessageVars> {
  @override
  final Iterable<Type> types = const [GSendMessageVars, _$GSendMessageVars];
  @override
  final String wireName = 'GSendMessageVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSendMessageVars object,
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
  GSendMessageVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendMessageVarsBuilder();

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

class _$GGetMessagesVars extends GGetMessagesVars {
  @override
  final String roomId;

  factory _$GGetMessagesVars(
          [void Function(GGetMessagesVarsBuilder)? updates]) =>
      (new GGetMessagesVarsBuilder()..update(updates))._build();

  _$GGetMessagesVars._({required this.roomId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GGetMessagesVars', 'roomId');
  }

  @override
  GGetMessagesVars rebuild(void Function(GGetMessagesVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessagesVarsBuilder toBuilder() =>
      new GGetMessagesVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMessagesVars && roomId == other.roomId;
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
    return (newBuiltValueToStringHelper(r'GGetMessagesVars')
          ..add('roomId', roomId))
        .toString();
  }
}

class GGetMessagesVarsBuilder
    implements Builder<GGetMessagesVars, GGetMessagesVarsBuilder> {
  _$GGetMessagesVars? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  GGetMessagesVarsBuilder();

  GGetMessagesVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMessagesVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMessagesVars;
  }

  @override
  void update(void Function(GGetMessagesVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessagesVars build() => _build();

  _$GGetMessagesVars _build() {
    final _$result = _$v ??
        new _$GGetMessagesVars._(
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GGetMessagesVars', 'roomId'));
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageVars extends GSendMessageVars {
  @override
  final String roomId;
  @override
  final String user;
  @override
  final String text;

  factory _$GSendMessageVars(
          [void Function(GSendMessageVarsBuilder)? updates]) =>
      (new GSendMessageVarsBuilder()..update(updates))._build();

  _$GSendMessageVars._(
      {required this.roomId, required this.user, required this.text})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GSendMessageVars', 'roomId');
    BuiltValueNullFieldError.checkNotNull(user, r'GSendMessageVars', 'user');
    BuiltValueNullFieldError.checkNotNull(text, r'GSendMessageVars', 'text');
  }

  @override
  GSendMessageVars rebuild(void Function(GSendMessageVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageVarsBuilder toBuilder() =>
      new GSendMessageVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageVars &&
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
    return (newBuiltValueToStringHelper(r'GSendMessageVars')
          ..add('roomId', roomId)
          ..add('user', user)
          ..add('text', text))
        .toString();
  }
}

class GSendMessageVarsBuilder
    implements Builder<GSendMessageVars, GSendMessageVarsBuilder> {
  _$GSendMessageVars? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  GSendMessageVarsBuilder();

  GSendMessageVarsBuilder get _$this {
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
  void replace(GSendMessageVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendMessageVars;
  }

  @override
  void update(void Function(GSendMessageVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageVars build() => _build();

  _$GSendMessageVars _build() {
    final _$result = _$v ??
        new _$GSendMessageVars._(
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GSendMessageVars', 'roomId'),
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GSendMessageVars', 'user'),
            text: BuiltValueNullFieldError.checkNotNull(
                text, r'GSendMessageVars', 'text'));
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

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
