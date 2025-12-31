// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetMessagesData> _$gGetMessagesDataSerializer =
    new _$GGetMessagesDataSerializer();
Serializer<GGetMessagesData_messages> _$gGetMessagesDataMessagesSerializer =
    new _$GGetMessagesData_messagesSerializer();
Serializer<GPostMessageData> _$gPostMessageDataSerializer =
    new _$GPostMessageDataSerializer();

class _$GGetMessagesDataSerializer
    implements StructuredSerializer<GGetMessagesData> {
  @override
  final Iterable<Type> types = const [GGetMessagesData, _$GGetMessagesData];
  @override
  final String wireName = 'GGetMessagesData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetMessagesData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.messages;
    if (value != null) {
      result
        ..add('messages')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(GGetMessagesData_messages)])));
    }
    return result;
  }

  @override
  GGetMessagesData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetMessagesDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'messages':
          result.messages.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GGetMessagesData_messages)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMessagesData_messagesSerializer
    implements StructuredSerializer<GGetMessagesData_messages> {
  @override
  final Iterable<Type> types = const [
    GGetMessagesData_messages,
    _$GGetMessagesData_messages
  ];
  @override
  final String wireName = 'GGetMessagesData_messages';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GGetMessagesData_messages object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetMessagesData_messages deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GGetMessagesData_messagesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
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

class _$GPostMessageDataSerializer
    implements StructuredSerializer<GPostMessageData> {
  @override
  final Iterable<Type> types = const [GPostMessageData, _$GPostMessageData];
  @override
  final String wireName = 'GPostMessageData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GPostMessageData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'postMessage',
      serializers.serialize(object.postMessage,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GPostMessageData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GPostMessageDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'postMessage':
          result.postMessage = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetMessagesData extends GGetMessagesData {
  @override
  final String G__typename;
  @override
  final BuiltList<GGetMessagesData_messages>? messages;

  factory _$GGetMessagesData(
          [void Function(GGetMessagesDataBuilder)? updates]) =>
      (new GGetMessagesDataBuilder()..update(updates))._build();

  _$GGetMessagesData._({required this.G__typename, this.messages}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetMessagesData', 'G__typename');
  }

  @override
  GGetMessagesData rebuild(void Function(GGetMessagesDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessagesDataBuilder toBuilder() =>
      new GGetMessagesDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMessagesData &&
        G__typename == other.G__typename &&
        messages == other.messages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, messages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMessagesData')
          ..add('G__typename', G__typename)
          ..add('messages', messages))
        .toString();
  }
}

class GGetMessagesDataBuilder
    implements Builder<GGetMessagesData, GGetMessagesDataBuilder> {
  _$GGetMessagesData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GGetMessagesData_messages>? _messages;
  ListBuilder<GGetMessagesData_messages> get messages =>
      _$this._messages ??= new ListBuilder<GGetMessagesData_messages>();
  set messages(ListBuilder<GGetMessagesData_messages>? messages) =>
      _$this._messages = messages;

  GGetMessagesDataBuilder() {
    GGetMessagesData._initializeBuilder(this);
  }

  GGetMessagesDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _messages = $v.messages?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMessagesData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMessagesData;
  }

  @override
  void update(void Function(GGetMessagesDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessagesData build() => _build();

  _$GGetMessagesData _build() {
    _$GGetMessagesData _$result;
    try {
      _$result = _$v ??
          new _$GGetMessagesData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GGetMessagesData', 'G__typename'),
              messages: _messages?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messages';
        _messages?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GGetMessagesData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GGetMessagesData_messages extends GGetMessagesData_messages {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String user;
  @override
  final String content;

  factory _$GGetMessagesData_messages(
          [void Function(GGetMessagesData_messagesBuilder)? updates]) =>
      (new GGetMessagesData_messagesBuilder()..update(updates))._build();

  _$GGetMessagesData_messages._(
      {required this.G__typename,
      required this.id,
      required this.user,
      required this.content})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetMessagesData_messages', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetMessagesData_messages', 'id');
    BuiltValueNullFieldError.checkNotNull(
        user, r'GGetMessagesData_messages', 'user');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GGetMessagesData_messages', 'content');
  }

  @override
  GGetMessagesData_messages rebuild(
          void Function(GGetMessagesData_messagesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMessagesData_messagesBuilder toBuilder() =>
      new GGetMessagesData_messagesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMessagesData_messages &&
        G__typename == other.G__typename &&
        id == other.id &&
        user == other.user &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMessagesData_messages')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('user', user)
          ..add('content', content))
        .toString();
  }
}

class GGetMessagesData_messagesBuilder
    implements
        Builder<GGetMessagesData_messages, GGetMessagesData_messagesBuilder> {
  _$GGetMessagesData_messages? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  GGetMessagesData_messagesBuilder() {
    GGetMessagesData_messages._initializeBuilder(this);
  }

  GGetMessagesData_messagesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _user = $v.user;
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetMessagesData_messages other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMessagesData_messages;
  }

  @override
  void update(void Function(GGetMessagesData_messagesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMessagesData_messages build() => _build();

  _$GGetMessagesData_messages _build() {
    final _$result = _$v ??
        new _$GGetMessagesData_messages._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GGetMessagesData_messages', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GGetMessagesData_messages', 'id'),
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GGetMessagesData_messages', 'user'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GGetMessagesData_messages', 'content'));
    replace(_$result);
    return _$result;
  }
}

class _$GPostMessageData extends GPostMessageData {
  @override
  final String G__typename;
  @override
  final String postMessage;

  factory _$GPostMessageData(
          [void Function(GPostMessageDataBuilder)? updates]) =>
      (new GPostMessageDataBuilder()..update(updates))._build();

  _$GPostMessageData._({required this.G__typename, required this.postMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GPostMessageData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        postMessage, r'GPostMessageData', 'postMessage');
  }

  @override
  GPostMessageData rebuild(void Function(GPostMessageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostMessageDataBuilder toBuilder() =>
      new GPostMessageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostMessageData &&
        G__typename == other.G__typename &&
        postMessage == other.postMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, postMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostMessageData')
          ..add('G__typename', G__typename)
          ..add('postMessage', postMessage))
        .toString();
  }
}

class GPostMessageDataBuilder
    implements Builder<GPostMessageData, GPostMessageDataBuilder> {
  _$GPostMessageData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _postMessage;
  String? get postMessage => _$this._postMessage;
  set postMessage(String? postMessage) => _$this._postMessage = postMessage;

  GPostMessageDataBuilder() {
    GPostMessageData._initializeBuilder(this);
  }

  GPostMessageDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _postMessage = $v.postMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostMessageData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GPostMessageData;
  }

  @override
  void update(void Function(GPostMessageDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostMessageData build() => _build();

  _$GPostMessageData _build() {
    final _$result = _$v ??
        new _$GPostMessageData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostMessageData', 'G__typename'),
            postMessage: BuiltValueNullFieldError.checkNotNull(
                postMessage, r'GPostMessageData', 'postMessage'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
