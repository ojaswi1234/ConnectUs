// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GFetchChatHistoryData> _$gFetchChatHistoryDataSerializer =
    new _$GFetchChatHistoryDataSerializer();
Serializer<GFetchChatHistoryData_messages>
    _$gFetchChatHistoryDataMessagesSerializer =
    new _$GFetchChatHistoryData_messagesSerializer();
Serializer<GsendMessageData> _$gsendMessageDataSerializer =
    new _$GsendMessageDataSerializer();
Serializer<GsendMessageData_postMessage>
    _$gsendMessageDataPostMessageSerializer =
    new _$GsendMessageData_postMessageSerializer();
Serializer<GListenToChatData> _$gListenToChatDataSerializer =
    new _$GListenToChatDataSerializer();
Serializer<GListenToChatData_messages> _$gListenToChatDataMessagesSerializer =
    new _$GListenToChatData_messagesSerializer();

class _$GFetchChatHistoryDataSerializer
    implements StructuredSerializer<GFetchChatHistoryData> {
  @override
  final Iterable<Type> types = const [
    GFetchChatHistoryData,
    _$GFetchChatHistoryData
  ];
  @override
  final String wireName = 'GFetchChatHistoryData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GFetchChatHistoryData object,
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
            specifiedType: const FullType(BuiltList,
                const [const FullType(GFetchChatHistoryData_messages)])));
    }
    return result;
  }

  @override
  GFetchChatHistoryData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GFetchChatHistoryDataBuilder();

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
                const FullType(GFetchChatHistoryData_messages)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GFetchChatHistoryData_messagesSerializer
    implements StructuredSerializer<GFetchChatHistoryData_messages> {
  @override
  final Iterable<Type> types = const [
    GFetchChatHistoryData_messages,
    _$GFetchChatHistoryData_messages
  ];
  @override
  final String wireName = 'GFetchChatHistoryData_messages';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GFetchChatHistoryData_messages object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GFetchChatHistoryData_messages deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GFetchChatHistoryData_messagesBuilder();

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
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GsendMessageDataSerializer
    implements StructuredSerializer<GsendMessageData> {
  @override
  final Iterable<Type> types = const [GsendMessageData, _$GsendMessageData];
  @override
  final String wireName = 'GsendMessageData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GsendMessageData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'postMessage',
      serializers.serialize(object.postMessage,
          specifiedType: const FullType(GsendMessageData_postMessage)),
    ];

    return result;
  }

  @override
  GsendMessageData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsendMessageDataBuilder();

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
                  specifiedType: const FullType(GsendMessageData_postMessage))!
              as GsendMessageData_postMessage);
          break;
      }
    }

    return result.build();
  }
}

class _$GsendMessageData_postMessageSerializer
    implements StructuredSerializer<GsendMessageData_postMessage> {
  @override
  final Iterable<Type> types = const [
    GsendMessageData_postMessage,
    _$GsendMessageData_postMessage
  ];
  @override
  final String wireName = 'GsendMessageData_postMessage';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GsendMessageData_postMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GsendMessageData_postMessage deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GsendMessageData_postMessageBuilder();

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
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GListenToChatDataSerializer
    implements StructuredSerializer<GListenToChatData> {
  @override
  final Iterable<Type> types = const [GListenToChatData, _$GListenToChatData];
  @override
  final String wireName = 'GListenToChatData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GListenToChatData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'messages',
      serializers.serialize(object.messages,
          specifiedType: const FullType(GListenToChatData_messages)),
    ];

    return result;
  }

  @override
  GListenToChatData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GListenToChatDataBuilder();

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
                  specifiedType: const FullType(GListenToChatData_messages))!
              as GListenToChatData_messages);
          break;
      }
    }

    return result.build();
  }
}

class _$GListenToChatData_messagesSerializer
    implements StructuredSerializer<GListenToChatData_messages> {
  @override
  final Iterable<Type> types = const [
    GListenToChatData_messages,
    _$GListenToChatData_messages
  ];
  @override
  final String wireName = 'GListenToChatData_messages';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GListenToChatData_messages object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GListenToChatData_messages deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GListenToChatData_messagesBuilder();

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
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GFetchChatHistoryData extends GFetchChatHistoryData {
  @override
  final String G__typename;
  @override
  final BuiltList<GFetchChatHistoryData_messages>? messages;

  factory _$GFetchChatHistoryData(
          [void Function(GFetchChatHistoryDataBuilder)? updates]) =>
      (new GFetchChatHistoryDataBuilder()..update(updates))._build();

  _$GFetchChatHistoryData._({required this.G__typename, this.messages})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GFetchChatHistoryData', 'G__typename');
  }

  @override
  GFetchChatHistoryData rebuild(
          void Function(GFetchChatHistoryDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFetchChatHistoryDataBuilder toBuilder() =>
      new GFetchChatHistoryDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFetchChatHistoryData &&
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
    return (newBuiltValueToStringHelper(r'GFetchChatHistoryData')
          ..add('G__typename', G__typename)
          ..add('messages', messages))
        .toString();
  }
}

class GFetchChatHistoryDataBuilder
    implements Builder<GFetchChatHistoryData, GFetchChatHistoryDataBuilder> {
  _$GFetchChatHistoryData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GFetchChatHistoryData_messages>? _messages;
  ListBuilder<GFetchChatHistoryData_messages> get messages =>
      _$this._messages ??= new ListBuilder<GFetchChatHistoryData_messages>();
  set messages(ListBuilder<GFetchChatHistoryData_messages>? messages) =>
      _$this._messages = messages;

  GFetchChatHistoryDataBuilder() {
    GFetchChatHistoryData._initializeBuilder(this);
  }

  GFetchChatHistoryDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _messages = $v.messages?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFetchChatHistoryData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFetchChatHistoryData;
  }

  @override
  void update(void Function(GFetchChatHistoryDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFetchChatHistoryData build() => _build();

  _$GFetchChatHistoryData _build() {
    _$GFetchChatHistoryData _$result;
    try {
      _$result = _$v ??
          new _$GFetchChatHistoryData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GFetchChatHistoryData', 'G__typename'),
              messages: _messages?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messages';
        _messages?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GFetchChatHistoryData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GFetchChatHistoryData_messages extends GFetchChatHistoryData_messages {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String roomId;
  @override
  final String user;
  @override
  final String text;
  @override
  final String createdAt;

  factory _$GFetchChatHistoryData_messages(
          [void Function(GFetchChatHistoryData_messagesBuilder)? updates]) =>
      (new GFetchChatHistoryData_messagesBuilder()..update(updates))._build();

  _$GFetchChatHistoryData_messages._(
      {required this.G__typename,
      required this.id,
      required this.roomId,
      required this.user,
      required this.text,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GFetchChatHistoryData_messages', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GFetchChatHistoryData_messages', 'id');
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GFetchChatHistoryData_messages', 'roomId');
    BuiltValueNullFieldError.checkNotNull(
        user, r'GFetchChatHistoryData_messages', 'user');
    BuiltValueNullFieldError.checkNotNull(
        text, r'GFetchChatHistoryData_messages', 'text');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GFetchChatHistoryData_messages', 'createdAt');
  }

  @override
  GFetchChatHistoryData_messages rebuild(
          void Function(GFetchChatHistoryData_messagesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFetchChatHistoryData_messagesBuilder toBuilder() =>
      new GFetchChatHistoryData_messagesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFetchChatHistoryData_messages &&
        G__typename == other.G__typename &&
        id == other.id &&
        roomId == other.roomId &&
        user == other.user &&
        text == other.text &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GFetchChatHistoryData_messages')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('roomId', roomId)
          ..add('user', user)
          ..add('text', text)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GFetchChatHistoryData_messagesBuilder
    implements
        Builder<GFetchChatHistoryData_messages,
            GFetchChatHistoryData_messagesBuilder> {
  _$GFetchChatHistoryData_messages? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  GFetchChatHistoryData_messagesBuilder() {
    GFetchChatHistoryData_messages._initializeBuilder(this);
  }

  GFetchChatHistoryData_messagesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _roomId = $v.roomId;
      _user = $v.user;
      _text = $v.text;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFetchChatHistoryData_messages other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GFetchChatHistoryData_messages;
  }

  @override
  void update(void Function(GFetchChatHistoryData_messagesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFetchChatHistoryData_messages build() => _build();

  _$GFetchChatHistoryData_messages _build() {
    final _$result = _$v ??
        new _$GFetchChatHistoryData_messages._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GFetchChatHistoryData_messages', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GFetchChatHistoryData_messages', 'id'),
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GFetchChatHistoryData_messages', 'roomId'),
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GFetchChatHistoryData_messages', 'user'),
            text: BuiltValueNullFieldError.checkNotNull(
                text, r'GFetchChatHistoryData_messages', 'text'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GFetchChatHistoryData_messages', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

class _$GsendMessageData extends GsendMessageData {
  @override
  final String G__typename;
  @override
  final GsendMessageData_postMessage postMessage;

  factory _$GsendMessageData(
          [void Function(GsendMessageDataBuilder)? updates]) =>
      (new GsendMessageDataBuilder()..update(updates))._build();

  _$GsendMessageData._({required this.G__typename, required this.postMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GsendMessageData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        postMessage, r'GsendMessageData', 'postMessage');
  }

  @override
  GsendMessageData rebuild(void Function(GsendMessageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsendMessageDataBuilder toBuilder() =>
      new GsendMessageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsendMessageData &&
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
    return (newBuiltValueToStringHelper(r'GsendMessageData')
          ..add('G__typename', G__typename)
          ..add('postMessage', postMessage))
        .toString();
  }
}

class GsendMessageDataBuilder
    implements Builder<GsendMessageData, GsendMessageDataBuilder> {
  _$GsendMessageData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GsendMessageData_postMessageBuilder? _postMessage;
  GsendMessageData_postMessageBuilder get postMessage =>
      _$this._postMessage ??= new GsendMessageData_postMessageBuilder();
  set postMessage(GsendMessageData_postMessageBuilder? postMessage) =>
      _$this._postMessage = postMessage;

  GsendMessageDataBuilder() {
    GsendMessageData._initializeBuilder(this);
  }

  GsendMessageDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _postMessage = $v.postMessage.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsendMessageData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsendMessageData;
  }

  @override
  void update(void Function(GsendMessageDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GsendMessageData build() => _build();

  _$GsendMessageData _build() {
    _$GsendMessageData _$result;
    try {
      _$result = _$v ??
          new _$GsendMessageData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GsendMessageData', 'G__typename'),
              postMessage: postMessage.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'postMessage';
        postMessage.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GsendMessageData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GsendMessageData_postMessage extends GsendMessageData_postMessage {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String roomId;
  @override
  final String user;
  @override
  final String text;
  @override
  final String createdAt;

  factory _$GsendMessageData_postMessage(
          [void Function(GsendMessageData_postMessageBuilder)? updates]) =>
      (new GsendMessageData_postMessageBuilder()..update(updates))._build();

  _$GsendMessageData_postMessage._(
      {required this.G__typename,
      required this.id,
      required this.roomId,
      required this.user,
      required this.text,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GsendMessageData_postMessage', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GsendMessageData_postMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GsendMessageData_postMessage', 'roomId');
    BuiltValueNullFieldError.checkNotNull(
        user, r'GsendMessageData_postMessage', 'user');
    BuiltValueNullFieldError.checkNotNull(
        text, r'GsendMessageData_postMessage', 'text');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GsendMessageData_postMessage', 'createdAt');
  }

  @override
  GsendMessageData_postMessage rebuild(
          void Function(GsendMessageData_postMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GsendMessageData_postMessageBuilder toBuilder() =>
      new GsendMessageData_postMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GsendMessageData_postMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        roomId == other.roomId &&
        user == other.user &&
        text == other.text &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GsendMessageData_postMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('roomId', roomId)
          ..add('user', user)
          ..add('text', text)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GsendMessageData_postMessageBuilder
    implements
        Builder<GsendMessageData_postMessage,
            GsendMessageData_postMessageBuilder> {
  _$GsendMessageData_postMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  GsendMessageData_postMessageBuilder() {
    GsendMessageData_postMessage._initializeBuilder(this);
  }

  GsendMessageData_postMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _roomId = $v.roomId;
      _user = $v.user;
      _text = $v.text;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GsendMessageData_postMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GsendMessageData_postMessage;
  }

  @override
  void update(void Function(GsendMessageData_postMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GsendMessageData_postMessage build() => _build();

  _$GsendMessageData_postMessage _build() {
    final _$result = _$v ??
        new _$GsendMessageData_postMessage._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GsendMessageData_postMessage', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GsendMessageData_postMessage', 'id'),
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GsendMessageData_postMessage', 'roomId'),
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GsendMessageData_postMessage', 'user'),
            text: BuiltValueNullFieldError.checkNotNull(
                text, r'GsendMessageData_postMessage', 'text'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GsendMessageData_postMessage', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

class _$GListenToChatData extends GListenToChatData {
  @override
  final String G__typename;
  @override
  final GListenToChatData_messages messages;

  factory _$GListenToChatData(
          [void Function(GListenToChatDataBuilder)? updates]) =>
      (new GListenToChatDataBuilder()..update(updates))._build();

  _$GListenToChatData._({required this.G__typename, required this.messages})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GListenToChatData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        messages, r'GListenToChatData', 'messages');
  }

  @override
  GListenToChatData rebuild(void Function(GListenToChatDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListenToChatDataBuilder toBuilder() =>
      new GListenToChatDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListenToChatData &&
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
    return (newBuiltValueToStringHelper(r'GListenToChatData')
          ..add('G__typename', G__typename)
          ..add('messages', messages))
        .toString();
  }
}

class GListenToChatDataBuilder
    implements Builder<GListenToChatData, GListenToChatDataBuilder> {
  _$GListenToChatData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GListenToChatData_messagesBuilder? _messages;
  GListenToChatData_messagesBuilder get messages =>
      _$this._messages ??= new GListenToChatData_messagesBuilder();
  set messages(GListenToChatData_messagesBuilder? messages) =>
      _$this._messages = messages;

  GListenToChatDataBuilder() {
    GListenToChatData._initializeBuilder(this);
  }

  GListenToChatDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _messages = $v.messages.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GListenToChatData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GListenToChatData;
  }

  @override
  void update(void Function(GListenToChatDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GListenToChatData build() => _build();

  _$GListenToChatData _build() {
    _$GListenToChatData _$result;
    try {
      _$result = _$v ??
          new _$GListenToChatData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GListenToChatData', 'G__typename'),
              messages: messages.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messages';
        messages.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GListenToChatData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GListenToChatData_messages extends GListenToChatData_messages {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String roomId;
  @override
  final String user;
  @override
  final String text;
  @override
  final String createdAt;

  factory _$GListenToChatData_messages(
          [void Function(GListenToChatData_messagesBuilder)? updates]) =>
      (new GListenToChatData_messagesBuilder()..update(updates))._build();

  _$GListenToChatData_messages._(
      {required this.G__typename,
      required this.id,
      required this.roomId,
      required this.user,
      required this.text,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GListenToChatData_messages', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GListenToChatData_messages', 'id');
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GListenToChatData_messages', 'roomId');
    BuiltValueNullFieldError.checkNotNull(
        user, r'GListenToChatData_messages', 'user');
    BuiltValueNullFieldError.checkNotNull(
        text, r'GListenToChatData_messages', 'text');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GListenToChatData_messages', 'createdAt');
  }

  @override
  GListenToChatData_messages rebuild(
          void Function(GListenToChatData_messagesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListenToChatData_messagesBuilder toBuilder() =>
      new GListenToChatData_messagesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListenToChatData_messages &&
        G__typename == other.G__typename &&
        id == other.id &&
        roomId == other.roomId &&
        user == other.user &&
        text == other.text &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GListenToChatData_messages')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('roomId', roomId)
          ..add('user', user)
          ..add('text', text)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GListenToChatData_messagesBuilder
    implements
        Builder<GListenToChatData_messages, GListenToChatData_messagesBuilder> {
  _$GListenToChatData_messages? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  GListenToChatData_messagesBuilder() {
    GListenToChatData_messages._initializeBuilder(this);
  }

  GListenToChatData_messagesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _roomId = $v.roomId;
      _user = $v.user;
      _text = $v.text;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GListenToChatData_messages other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GListenToChatData_messages;
  }

  @override
  void update(void Function(GListenToChatData_messagesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GListenToChatData_messages build() => _build();

  _$GListenToChatData_messages _build() {
    final _$result = _$v ??
        new _$GListenToChatData_messages._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GListenToChatData_messages', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GListenToChatData_messages', 'id'),
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GListenToChatData_messages', 'roomId'),
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GListenToChatData_messages', 'user'),
            text: BuiltValueNullFieldError.checkNotNull(
                text, r'GListenToChatData_messages', 'text'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GListenToChatData_messages', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
