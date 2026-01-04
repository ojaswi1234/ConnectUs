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

class _$GGetMessagesVarsSerializer
    implements StructuredSerializer<GGetMessagesVars> {
  @override
  final Iterable<Type> types = const [GGetMessagesVars, _$GGetMessagesVars];
  @override
  final String wireName = 'GGetMessagesVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetMessagesVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GGetMessagesVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GGetMessagesVarsBuilder().build();
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
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
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
        case 'user':
          result.user = serializers.deserialize(value,
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
    return <Object?>[];
  }

  @override
  GOnNewMessageVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GOnNewMessageVarsBuilder().build();
  }
}

class _$GGetMessagesVars extends GGetMessagesVars {
  factory _$GGetMessagesVars(
          [void Function(GGetMessagesVarsBuilder)? updates]) =>
      (new GGetMessagesVarsBuilder()..update(updates))._build();

  _$GGetMessagesVars._() : super._();

  @override
  GGetMessagesVars rebuild(void Function(GGetMessagesVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessagesVarsBuilder toBuilder() =>
      new GGetMessagesVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMessagesVars;
  }

  @override
  int get hashCode {
    return 978850129;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetMessagesVars').toString();
  }
}

class GGetMessagesVarsBuilder
    implements Builder<GGetMessagesVars, GGetMessagesVarsBuilder> {
  _$GGetMessagesVars? _$v;

  GGetMessagesVarsBuilder();

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
    final _$result = _$v ?? new _$GGetMessagesVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GPostMessageVars extends GPostMessageVars {
  @override
  final String user;
  @override
  final String content;

  factory _$GPostMessageVars(
          [void Function(GPostMessageVarsBuilder)? updates]) =>
      (new GPostMessageVarsBuilder()..update(updates))._build();

  _$GPostMessageVars._({required this.user, required this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(user, r'GPostMessageVars', 'user');
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
        user == other.user &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostMessageVars')
          ..add('user', user)
          ..add('content', content))
        .toString();
  }
}

class GPostMessageVarsBuilder
    implements Builder<GPostMessageVars, GPostMessageVarsBuilder> {
  _$GPostMessageVars? _$v;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GPostMessageVarsBuilder();

  GPostMessageVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user;
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
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GPostMessageVars', 'user'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GPostMessageVars', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$GOnNewMessageVars extends GOnNewMessageVars {
  factory _$GOnNewMessageVars(
          [void Function(GOnNewMessageVarsBuilder)? updates]) =>
      (new GOnNewMessageVarsBuilder()..update(updates))._build();

  _$GOnNewMessageVars._() : super._();

  @override
  GOnNewMessageVars rebuild(void Function(GOnNewMessageVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOnNewMessageVarsBuilder toBuilder() =>
      new GOnNewMessageVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOnNewMessageVars;
  }

  @override
  int get hashCode {
    return 507391016;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GOnNewMessageVars').toString();
  }
}

class GOnNewMessageVarsBuilder
    implements Builder<GOnNewMessageVars, GOnNewMessageVarsBuilder> {
  _$GOnNewMessageVars? _$v;

  GOnNewMessageVarsBuilder();

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
    final _$result = _$v ?? new _$GOnNewMessageVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
