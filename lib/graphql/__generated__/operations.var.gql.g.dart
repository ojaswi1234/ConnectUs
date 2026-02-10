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
    return <Object?>[];
  }

  @override
  GFetchChatHistoryVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GFetchChatHistoryVarsBuilder().build();
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
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
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
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'roomId':
          result.roomId = serializers.deserialize(value,
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
    return <Object?>[];
  }

  @override
  GListenToChatVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GListenToChatVarsBuilder().build();
  }
}

class _$GFetchChatHistoryVars extends GFetchChatHistoryVars {
  factory _$GFetchChatHistoryVars(
          [void Function(GFetchChatHistoryVarsBuilder)? updates]) =>
      (new GFetchChatHistoryVarsBuilder()..update(updates))._build();

  _$GFetchChatHistoryVars._() : super._();

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
    return other is GFetchChatHistoryVars;
  }

  @override
  int get hashCode {
    return 378426416;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GFetchChatHistoryVars').toString();
  }
}

class GFetchChatHistoryVarsBuilder
    implements Builder<GFetchChatHistoryVars, GFetchChatHistoryVarsBuilder> {
  _$GFetchChatHistoryVars? _$v;

  GFetchChatHistoryVarsBuilder();

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
    final _$result = _$v ?? new _$GFetchChatHistoryVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GsendMessageVars extends GsendMessageVars {
  @override
  final String user;
  @override
  final String text;
  @override
  final String roomId;

  factory _$GsendMessageVars(
          [void Function(GsendMessageVarsBuilder)? updates]) =>
      (new GsendMessageVarsBuilder()..update(updates))._build();

  _$GsendMessageVars._(
      {required this.user, required this.text, required this.roomId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(user, r'GsendMessageVars', 'user');
    BuiltValueNullFieldError.checkNotNull(text, r'GsendMessageVars', 'text');
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GsendMessageVars', 'roomId');
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
        user == other.user &&
        text == other.text &&
        roomId == other.roomId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GsendMessageVars')
          ..add('user', user)
          ..add('text', text)
          ..add('roomId', roomId))
        .toString();
  }
}

class GsendMessageVarsBuilder
    implements Builder<GsendMessageVars, GsendMessageVarsBuilder> {
  _$GsendMessageVars? _$v;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  GsendMessageVarsBuilder();

  GsendMessageVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
      _text = $v.text;
      _roomId = $v.roomId;
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
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GsendMessageVars', 'user'),
            text: BuiltValueNullFieldError.checkNotNull(
                text, r'GsendMessageVars', 'text'),
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GsendMessageVars', 'roomId'));
    replace(_$result);
    return _$result;
  }
}

class _$GListenToChatVars extends GListenToChatVars {
  factory _$GListenToChatVars(
          [void Function(GListenToChatVarsBuilder)? updates]) =>
      (new GListenToChatVarsBuilder()..update(updates))._build();

  _$GListenToChatVars._() : super._();

  @override
  GListenToChatVars rebuild(void Function(GListenToChatVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListenToChatVarsBuilder toBuilder() =>
      new GListenToChatVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListenToChatVars;
  }

  @override
  int get hashCode {
    return 491119253;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GListenToChatVars').toString();
  }
}

class GListenToChatVarsBuilder
    implements Builder<GListenToChatVars, GListenToChatVarsBuilder> {
  _$GListenToChatVars? _$v;

  GListenToChatVarsBuilder();

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
    final _$result = _$v ?? new _$GListenToChatVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
