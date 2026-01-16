// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetMessagesVars> _$gGetMessagesVarsSerializer =
    new _$GGetMessagesVarsSerializer();
Serializer<GPostMessageVars> _$gPostMessageVarsSerializer =
    new _$GPostMessageVarsSerializer();
Serializer<GOnNewMessageVars> _$gOnNewMessageVarsSerializer =
    new _$GOnNewMessageVarsSerializer();
Serializer<GListenToIncomingMessagesVars>
    _$gListenToIncomingMessagesVarsSerializer =
    new _$GListenToIncomingMessagesVarsSerializer();
Serializer<GChatMessageFieldsVars> _$gChatMessageFieldsVarsSerializer =
    new _$GChatMessageFieldsVarsSerializer();

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

class _$GPostMessageVarsSerializer
    implements StructuredSerializer<GPostMessageVars> {
  @override
  final Iterable<Type> types = const [GPostMessageVars, _$GPostMessageVars];
  @override
  final String wireName = 'GPostMessageVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostMessageVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'to',
      serializers.serialize(object.to, specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GPostMessageVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GPostMessageVarsBuilder();

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
        case 'to':
          result.to = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GOnNewMessageVarsSerializer
    implements StructuredSerializer<GOnNewMessageVars> {
  @override
  final Iterable<Type> types = const [GOnNewMessageVars, _$GOnNewMessageVars];
  @override
  final String wireName = 'GOnNewMessageVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GOnNewMessageVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GOnNewMessageVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GOnNewMessageVarsBuilder();

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

class _$GListenToIncomingMessagesVarsSerializer
    implements StructuredSerializer<GListenToIncomingMessagesVars> {
  @override
  final Iterable<Type> types = const [
    GListenToIncomingMessagesVars,
    _$GListenToIncomingMessagesVars
  ];
  @override
  final String wireName = 'GListenToIncomingMessagesVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GListenToIncomingMessagesVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GListenToIncomingMessagesVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GListenToIncomingMessagesVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GChatMessageFieldsVarsSerializer
    implements StructuredSerializer<GChatMessageFieldsVars> {
  @override
  final Iterable<Type> types = const [
    GChatMessageFieldsVars,
    _$GChatMessageFieldsVars
  ];
  @override
  final String wireName = 'GChatMessageFieldsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GChatMessageFieldsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GChatMessageFieldsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GChatMessageFieldsVarsBuilder().build();
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

class _$GPostMessageVars extends GPostMessageVars {
  @override
  final String roomId;
  @override
  final String user;
  @override
  final String to;
  @override
  final String content;

  factory _$GPostMessageVars(
          [void Function(GPostMessageVarsBuilder)? updates]) =>
      (new GPostMessageVarsBuilder()..update(updates))._build();

  _$GPostMessageVars._(
      {required this.roomId,
      required this.user,
      required this.to,
      required this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GPostMessageVars', 'roomId');
    BuiltValueNullFieldError.checkNotNull(user, r'GPostMessageVars', 'user');
    BuiltValueNullFieldError.checkNotNull(to, r'GPostMessageVars', 'to');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GPostMessageVars', 'content');
  }

  @override
  GPostMessageVars rebuild(void Function(GPostMessageVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostMessageVarsBuilder toBuilder() =>
      new GPostMessageVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostMessageVars &&
        roomId == other.roomId &&
        user == other.user &&
        to == other.to &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostMessageVars')
          ..add('roomId', roomId)
          ..add('user', user)
          ..add('to', to)
          ..add('content', content))
        .toString();
  }
}

class GPostMessageVarsBuilder
    implements Builder<GPostMessageVars, GPostMessageVarsBuilder> {
  _$GPostMessageVars? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GPostMessageVarsBuilder();

  GPostMessageVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _user = $v.user;
      _to = $v.to;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostMessageVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GPostMessageVars;
  }

  @override
  void update(void Function(GPostMessageVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostMessageVars build() => _build();

  _$GPostMessageVars _build() {
    final _$result = _$v ??
        new _$GPostMessageVars._(
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GPostMessageVars', 'roomId'),
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GPostMessageVars', 'user'),
            to: BuiltValueNullFieldError.checkNotNull(
                to, r'GPostMessageVars', 'to'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GPostMessageVars', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$GOnNewMessageVars extends GOnNewMessageVars {
  @override
  final String roomId;

  factory _$GOnNewMessageVars(
          [void Function(GOnNewMessageVarsBuilder)? updates]) =>
      (new GOnNewMessageVarsBuilder()..update(updates))._build();

  _$GOnNewMessageVars._({required this.roomId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GOnNewMessageVars', 'roomId');
  }

  @override
  GOnNewMessageVars rebuild(void Function(GOnNewMessageVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOnNewMessageVarsBuilder toBuilder() =>
      new GOnNewMessageVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOnNewMessageVars && roomId == other.roomId;
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
    return (newBuiltValueToStringHelper(r'GOnNewMessageVars')
          ..add('roomId', roomId))
        .toString();
  }
}

class GOnNewMessageVarsBuilder
    implements Builder<GOnNewMessageVars, GOnNewMessageVarsBuilder> {
  _$GOnNewMessageVars? _$v;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  GOnNewMessageVarsBuilder();

  GOnNewMessageVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roomId = $v.roomId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOnNewMessageVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GOnNewMessageVars;
  }

  @override
  void update(void Function(GOnNewMessageVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOnNewMessageVars build() => _build();

  _$GOnNewMessageVars _build() {
    final _$result = _$v ??
        new _$GOnNewMessageVars._(
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GOnNewMessageVars', 'roomId'));
    replace(_$result);
    return _$result;
  }
}

class _$GListenToIncomingMessagesVars extends GListenToIncomingMessagesVars {
  @override
  final String user;

  factory _$GListenToIncomingMessagesVars(
          [void Function(GListenToIncomingMessagesVarsBuilder)? updates]) =>
      (new GListenToIncomingMessagesVarsBuilder()..update(updates))._build();

  _$GListenToIncomingMessagesVars._({required this.user}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        user, r'GListenToIncomingMessagesVars', 'user');
  }

  @override
  GListenToIncomingMessagesVars rebuild(
          void Function(GListenToIncomingMessagesVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListenToIncomingMessagesVarsBuilder toBuilder() =>
      new GListenToIncomingMessagesVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListenToIncomingMessagesVars && user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GListenToIncomingMessagesVars')
          ..add('user', user))
        .toString();
  }
}

class GListenToIncomingMessagesVarsBuilder
    implements
        Builder<GListenToIncomingMessagesVars,
            GListenToIncomingMessagesVarsBuilder> {
  _$GListenToIncomingMessagesVars? _$v;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  GListenToIncomingMessagesVarsBuilder();

  GListenToIncomingMessagesVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GListenToIncomingMessagesVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GListenToIncomingMessagesVars;
  }

  @override
  void update(void Function(GListenToIncomingMessagesVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GListenToIncomingMessagesVars build() => _build();

  _$GListenToIncomingMessagesVars _build() {
    final _$result = _$v ??
        new _$GListenToIncomingMessagesVars._(
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GListenToIncomingMessagesVars', 'user'));
    replace(_$result);
    return _$result;
  }
}

class _$GChatMessageFieldsVars extends GChatMessageFieldsVars {
  factory _$GChatMessageFieldsVars(
          [void Function(GChatMessageFieldsVarsBuilder)? updates]) =>
      (new GChatMessageFieldsVarsBuilder()..update(updates))._build();

  _$GChatMessageFieldsVars._() : super._();

  @override
  GChatMessageFieldsVars rebuild(
          void Function(GChatMessageFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GChatMessageFieldsVarsBuilder toBuilder() =>
      new GChatMessageFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GChatMessageFieldsVars;
  }

  @override
  int get hashCode {
    return 716418581;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GChatMessageFieldsVars').toString();
  }
}

class GChatMessageFieldsVarsBuilder
    implements Builder<GChatMessageFieldsVars, GChatMessageFieldsVarsBuilder> {
  _$GChatMessageFieldsVars? _$v;

  GChatMessageFieldsVarsBuilder();

  @override
  void replace(GChatMessageFieldsVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GChatMessageFieldsVars;
  }

  @override
  void update(void Function(GChatMessageFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GChatMessageFieldsVars build() => _build();

  _$GChatMessageFieldsVars _build() {
    final _$result = _$v ?? new _$GChatMessageFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
