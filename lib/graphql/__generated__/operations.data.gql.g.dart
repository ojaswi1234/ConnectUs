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
Serializer<GPostMessageData_postMessage>
    _$gPostMessageDataPostMessageSerializer =
    new _$GPostMessageData_postMessageSerializer();
Serializer<GOnNewMessageData> _$gOnNewMessageDataSerializer =
    new _$GOnNewMessageDataSerializer();
Serializer<GOnNewMessageData_messageAdded>
    _$gOnNewMessageDataMessageAddedSerializer =
    new _$GOnNewMessageData_messageAddedSerializer();

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
      'createdAt',
      serializers.serialize(object.createdAt,
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
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
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
          specifiedType: const FullType(GPostMessageData_postMessage)),
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
          result.postMessage.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GPostMessageData_postMessage))!
              as GPostMessageData_postMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$GPostMessageData_postMessageSerializer
    implements StructuredSerializer<GPostMessageData_postMessage> {
  @override
  final Iterable<Type> types = const [
    GPostMessageData_postMessage,
    _$GPostMessageData_postMessage
  ];
  @override
  final String wireName = 'GPostMessageData_postMessage';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPostMessageData_postMessage object,
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
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GPostMessageData_postMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GPostMessageData_postMessageBuilder();

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
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GOnNewMessageDataSerializer
    implements StructuredSerializer<GOnNewMessageData> {
  @override
  final Iterable<Type> types = const [GOnNewMessageData, _$GOnNewMessageData];
  @override
  final String wireName = 'GOnNewMessageData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GOnNewMessageData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'messageAdded',
      serializers.serialize(object.messageAdded,
          specifiedType: const FullType(GOnNewMessageData_messageAdded)),
    ];

    return result;
  }

  @override
  GOnNewMessageData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GOnNewMessageDataBuilder();

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
        case 'messageAdded':
          result.messageAdded.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GOnNewMessageData_messageAdded))!
              as GOnNewMessageData_messageAdded);
          break;
      }
    }

    return result.build();
  }
}

class _$GOnNewMessageData_messageAddedSerializer
    implements StructuredSerializer<GOnNewMessageData_messageAdded> {
  @override
  final Iterable<Type> types = const [
    GOnNewMessageData_messageAdded,
    _$GOnNewMessageData_messageAdded
  ];
  @override
  final String wireName = 'GOnNewMessageData_messageAdded';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GOnNewMessageData_messageAdded object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GOnNewMessageData_messageAdded deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GOnNewMessageData_messageAddedBuilder();

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
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
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
  @override
  final String createdAt;

  factory _$GGetMessagesData_messages(
          [void Function(GGetMessagesData_messagesBuilder)? updates]) =>
      (new GGetMessagesData_messagesBuilder()..update(updates))._build();

  _$GGetMessagesData_messages._(
      {required this.G__typename,
      required this.id,
      required this.user,
      required this.content,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetMessagesData_messages', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetMessagesData_messages', 'id');
    BuiltValueNullFieldError.checkNotNull(
        user, r'GGetMessagesData_messages', 'user');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GGetMessagesData_messages', 'content');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GGetMessagesData_messages', 'createdAt');
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
        content == other.content &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetMessagesData_messages')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('user', user)
          ..add('content', content)
          ..add('createdAt', createdAt))
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

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

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
      _createdAt = $v.createdAt;
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
                content, r'GGetMessagesData_messages', 'content'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GGetMessagesData_messages', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

class _$GPostMessageData extends GPostMessageData {
  @override
  final String G__typename;
  @override
  final GPostMessageData_postMessage postMessage;

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

  GPostMessageData_postMessageBuilder? _postMessage;
  GPostMessageData_postMessageBuilder get postMessage =>
      _$this._postMessage ??= new GPostMessageData_postMessageBuilder();
  set postMessage(GPostMessageData_postMessageBuilder? postMessage) =>
      _$this._postMessage = postMessage;

  GPostMessageDataBuilder() {
    GPostMessageData._initializeBuilder(this);
  }

  GPostMessageDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _postMessage = $v.postMessage.toBuilder();
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
    _$GPostMessageData _$result;
    try {
      _$result = _$v ??
          new _$GPostMessageData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GPostMessageData', 'G__typename'),
              postMessage: postMessage.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'postMessage';
        postMessage.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GPostMessageData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPostMessageData_postMessage extends GPostMessageData_postMessage {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String user;
  @override
  final String content;
  @override
  final String createdAt;

  factory _$GPostMessageData_postMessage(
          [void Function(GPostMessageData_postMessageBuilder)? updates]) =>
      (new GPostMessageData_postMessageBuilder()..update(updates))._build();

  _$GPostMessageData_postMessage._(
      {required this.G__typename,
      required this.id,
      required this.user,
      required this.content,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GPostMessageData_postMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GPostMessageData_postMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(
        user, r'GPostMessageData_postMessage', 'user');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GPostMessageData_postMessage', 'content');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GPostMessageData_postMessage', 'createdAt');
  }

  @override
  GPostMessageData_postMessage rebuild(
          void Function(GPostMessageData_postMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPostMessageData_postMessageBuilder toBuilder() =>
      new GPostMessageData_postMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPostMessageData_postMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        user == other.user &&
        content == other.content &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPostMessageData_postMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('user', user)
          ..add('content', content)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GPostMessageData_postMessageBuilder
    implements
        Builder<GPostMessageData_postMessage,
            GPostMessageData_postMessageBuilder> {
  _$GPostMessageData_postMessage? _$v;

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

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  GPostMessageData_postMessageBuilder() {
    GPostMessageData_postMessage._initializeBuilder(this);
  }

  GPostMessageData_postMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _user = $v.user;
      _content = $v.content;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPostMessageData_postMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GPostMessageData_postMessage;
  }

  @override
  void update(void Function(GPostMessageData_postMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPostMessageData_postMessage build() => _build();

  _$GPostMessageData_postMessage _build() {
    final _$result = _$v ??
        new _$GPostMessageData_postMessage._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPostMessageData_postMessage', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GPostMessageData_postMessage', 'id'),
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GPostMessageData_postMessage', 'user'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GPostMessageData_postMessage', 'content'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GPostMessageData_postMessage', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

class _$GOnNewMessageData extends GOnNewMessageData {
  @override
  final String G__typename;
  @override
  final GOnNewMessageData_messageAdded messageAdded;

  factory _$GOnNewMessageData(
          [void Function(GOnNewMessageDataBuilder)? updates]) =>
      (new GOnNewMessageDataBuilder()..update(updates))._build();

  _$GOnNewMessageData._({required this.G__typename, required this.messageAdded})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GOnNewMessageData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        messageAdded, r'GOnNewMessageData', 'messageAdded');
  }

  @override
  GOnNewMessageData rebuild(void Function(GOnNewMessageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOnNewMessageDataBuilder toBuilder() =>
      new GOnNewMessageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOnNewMessageData &&
        G__typename == other.G__typename &&
        messageAdded == other.messageAdded;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, messageAdded.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOnNewMessageData')
          ..add('G__typename', G__typename)
          ..add('messageAdded', messageAdded))
        .toString();
  }
}

class GOnNewMessageDataBuilder
    implements Builder<GOnNewMessageData, GOnNewMessageDataBuilder> {
  _$GOnNewMessageData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GOnNewMessageData_messageAddedBuilder? _messageAdded;
  GOnNewMessageData_messageAddedBuilder get messageAdded =>
      _$this._messageAdded ??= new GOnNewMessageData_messageAddedBuilder();
  set messageAdded(GOnNewMessageData_messageAddedBuilder? messageAdded) =>
      _$this._messageAdded = messageAdded;

  GOnNewMessageDataBuilder() {
    GOnNewMessageData._initializeBuilder(this);
  }

  GOnNewMessageDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _messageAdded = $v.messageAdded.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOnNewMessageData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GOnNewMessageData;
  }

  @override
  void update(void Function(GOnNewMessageDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOnNewMessageData build() => _build();

  _$GOnNewMessageData _build() {
    _$GOnNewMessageData _$result;
    try {
      _$result = _$v ??
          new _$GOnNewMessageData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GOnNewMessageData', 'G__typename'),
              messageAdded: messageAdded.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messageAdded';
        messageAdded.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GOnNewMessageData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GOnNewMessageData_messageAdded extends GOnNewMessageData_messageAdded {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String content;
  @override
  final String user;
  @override
  final String createdAt;

  factory _$GOnNewMessageData_messageAdded(
          [void Function(GOnNewMessageData_messageAddedBuilder)? updates]) =>
      (new GOnNewMessageData_messageAddedBuilder()..update(updates))._build();

  _$GOnNewMessageData_messageAdded._(
      {required this.G__typename,
      required this.id,
      required this.content,
      required this.user,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GOnNewMessageData_messageAdded', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GOnNewMessageData_messageAdded', 'id');
    BuiltValueNullFieldError.checkNotNull(
        content, r'GOnNewMessageData_messageAdded', 'content');
    BuiltValueNullFieldError.checkNotNull(
        user, r'GOnNewMessageData_messageAdded', 'user');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GOnNewMessageData_messageAdded', 'createdAt');
  }

  @override
  GOnNewMessageData_messageAdded rebuild(
          void Function(GOnNewMessageData_messageAddedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOnNewMessageData_messageAddedBuilder toBuilder() =>
      new GOnNewMessageData_messageAddedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOnNewMessageData_messageAdded &&
        G__typename == other.G__typename &&
        id == other.id &&
        content == other.content &&
        user == other.user &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOnNewMessageData_messageAdded')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('content', content)
          ..add('user', user)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GOnNewMessageData_messageAddedBuilder
    implements
        Builder<GOnNewMessageData_messageAdded,
            GOnNewMessageData_messageAddedBuilder> {
  _$GOnNewMessageData_messageAdded? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  GOnNewMessageData_messageAddedBuilder() {
    GOnNewMessageData_messageAdded._initializeBuilder(this);
  }

  GOnNewMessageData_messageAddedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _content = $v.content;
      _user = $v.user;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOnNewMessageData_messageAdded other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GOnNewMessageData_messageAdded;
  }

  @override
  void update(void Function(GOnNewMessageData_messageAddedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOnNewMessageData_messageAdded build() => _build();

  _$GOnNewMessageData_messageAdded _build() {
    final _$result = _$v ??
        new _$GOnNewMessageData_messageAdded._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GOnNewMessageData_messageAdded', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GOnNewMessageData_messageAdded', 'id'),
            content: BuiltValueNullFieldError.checkNotNull(
                content, r'GOnNewMessageData_messageAdded', 'content'),
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GOnNewMessageData_messageAdded', 'user'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GOnNewMessageData_messageAdded', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
