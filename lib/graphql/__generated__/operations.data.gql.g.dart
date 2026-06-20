// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetMessagesData> _$gGetMessagesDataSerializer =
    new _$GGetMessagesDataSerializer();
Serializer<GGetMessagesData_messages> _$gGetMessagesDataMessagesSerializer =
    new _$GGetMessagesData_messagesSerializer();
Serializer<GSendMessageData> _$gSendMessageDataSerializer =
    new _$GSendMessageDataSerializer();
Serializer<GListenToChatData> _$gListenToChatDataSerializer =
    new _$GListenToChatDataSerializer();
Serializer<GListenToChatData_messages> _$gListenToChatDataMessagesSerializer =
    new _$GListenToChatData_messagesSerializer();

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
      'messages',
      serializers.serialize(object.messages,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GGetMessagesData_messages)])),
    ];

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
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
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
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendMessageDataSerializer
    implements StructuredSerializer<GSendMessageData> {
  @override
  final Iterable<Type> types = const [GSendMessageData, _$GSendMessageData];
  @override
  final String wireName = 'GSendMessageData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSendMessageData object,
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
  GSendMessageData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendMessageDataBuilder();

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
          specifiedType: const FullType(
              BuiltList, const [const FullType(GListenToChatData_messages)])),
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
              specifiedType: const FullType(BuiltList, const [
                const FullType(GListenToChatData_messages)
              ]))! as BuiltList<Object?>);
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
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(String)),
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
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
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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
  final BuiltList<GGetMessagesData_messages> messages;

  factory _$GGetMessagesData(
          [void Function(GGetMessagesDataBuilder)? updates]) =>
      (new GGetMessagesDataBuilder()..update(updates))._build();

  _$GGetMessagesData._({required this.G__typename, required this.messages})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetMessagesData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        messages, r'GGetMessagesData', 'messages');
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
      _messages = $v.messages.toBuilder();
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
              messages: messages.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messages';
        messages.build();
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
  final String text;
  @override
  final String roomId;
  @override
  final String? createdAt;

  factory _$GGetMessagesData_messages(
          [void Function(GGetMessagesData_messagesBuilder)? updates]) =>
      (new GGetMessagesData_messagesBuilder()..update(updates))._build();

  _$GGetMessagesData_messages._(
      {required this.G__typename,
      required this.id,
      required this.user,
      required this.text,
      required this.roomId,
      this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GGetMessagesData_messages', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GGetMessagesData_messages', 'id');
    BuiltValueNullFieldError.checkNotNull(
        user, r'GGetMessagesData_messages', 'user');
    BuiltValueNullFieldError.checkNotNull(
        text, r'GGetMessagesData_messages', 'text');
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GGetMessagesData_messages', 'roomId');
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
        text == other.text &&
        roomId == other.roomId &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, roomId.hashCode);
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
          ..add('text', text)
          ..add('roomId', roomId)
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

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

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
      _text = $v.text;
      _roomId = $v.roomId;
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
            text: BuiltValueNullFieldError.checkNotNull(
                text, r'GGetMessagesData_messages', 'text'),
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GGetMessagesData_messages', 'roomId'),
            createdAt: createdAt);
    replace(_$result);
    return _$result;
  }
}

class _$GSendMessageData extends GSendMessageData {
  @override
  final String G__typename;
  @override
  final String postMessage;

  factory _$GSendMessageData(
          [void Function(GSendMessageDataBuilder)? updates]) =>
      (new GSendMessageDataBuilder()..update(updates))._build();

  _$GSendMessageData._({required this.G__typename, required this.postMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSendMessageData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        postMessage, r'GSendMessageData', 'postMessage');
  }

  @override
  GSendMessageData rebuild(void Function(GSendMessageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageDataBuilder toBuilder() =>
      new GSendMessageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageData &&
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
    return (newBuiltValueToStringHelper(r'GSendMessageData')
          ..add('G__typename', G__typename)
          ..add('postMessage', postMessage))
        .toString();
  }
}

class GSendMessageDataBuilder
    implements Builder<GSendMessageData, GSendMessageDataBuilder> {
  _$GSendMessageData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _postMessage;
  String? get postMessage => _$this._postMessage;
  set postMessage(String? postMessage) => _$this._postMessage = postMessage;

  GSendMessageDataBuilder() {
    GSendMessageData._initializeBuilder(this);
  }

  GSendMessageDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _postMessage = $v.postMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendMessageData;
  }

  @override
  void update(void Function(GSendMessageDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageData build() => _build();

  _$GSendMessageData _build() {
    final _$result = _$v ??
        new _$GSendMessageData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GSendMessageData', 'G__typename'),
            postMessage: BuiltValueNullFieldError.checkNotNull(
                postMessage, r'GSendMessageData', 'postMessage'));
    replace(_$result);
    return _$result;
  }
}

class _$GListenToChatData extends GListenToChatData {
  @override
  final String G__typename;
  @override
  final BuiltList<GListenToChatData_messages> messages;

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

  ListBuilder<GListenToChatData_messages>? _messages;
  ListBuilder<GListenToChatData_messages> get messages =>
      _$this._messages ??= new ListBuilder<GListenToChatData_messages>();
  set messages(ListBuilder<GListenToChatData_messages>? messages) =>
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
  final String user;
  @override
  final String text;
  @override
  final String roomId;
  @override
  final String? createdAt;

  factory _$GListenToChatData_messages(
          [void Function(GListenToChatData_messagesBuilder)? updates]) =>
      (new GListenToChatData_messagesBuilder()..update(updates))._build();

  _$GListenToChatData_messages._(
      {required this.G__typename,
      required this.id,
      required this.user,
      required this.text,
      required this.roomId,
      this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GListenToChatData_messages', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GListenToChatData_messages', 'id');
    BuiltValueNullFieldError.checkNotNull(
        user, r'GListenToChatData_messages', 'user');
    BuiltValueNullFieldError.checkNotNull(
        text, r'GListenToChatData_messages', 'text');
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GListenToChatData_messages', 'roomId');
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
        user == other.user &&
        text == other.text &&
        roomId == other.roomId &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GListenToChatData_messages')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('user', user)
          ..add('text', text)
          ..add('roomId', roomId)
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

  String? _user;
  String? get user => _$this._user;
  set user(String? user) => _$this._user = user;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

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
      _user = $v.user;
      _text = $v.text;
      _roomId = $v.roomId;
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
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'GListenToChatData_messages', 'user'),
            text: BuiltValueNullFieldError.checkNotNull(
                text, r'GListenToChatData_messages', 'text'),
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GListenToChatData_messages', 'roomId'),
            createdAt: createdAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
