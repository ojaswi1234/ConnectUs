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
Serializer<GSearchUsersData> _$gSearchUsersDataSerializer =
    new _$GSearchUsersDataSerializer();
Serializer<GSearchUsersData_searchUsers>
    _$gSearchUsersDataSearchUsersSerializer =
    new _$GSearchUsersData_searchUsersSerializer();
Serializer<GSendCallSignalData> _$gSendCallSignalDataSerializer =
    new _$GSendCallSignalDataSerializer();
Serializer<GListenToCallSignalsData> _$gListenToCallSignalsDataSerializer =
    new _$GListenToCallSignalsDataSerializer();
Serializer<GListenToCallSignalsData_callSignals>
    _$gListenToCallSignalsDataCallSignalsSerializer =
    new _$GListenToCallSignalsData_callSignalsSerializer();
Serializer<GAskAssistantData> _$gAskAssistantDataSerializer =
    new _$GAskAssistantDataSerializer();

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
      'messages',
      serializers.serialize(object.messages,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GFetchChatHistoryData_messages)])),
    ];

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
      'senderId',
      serializers.serialize(object.senderId,
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
        case 'senderId':
          result.senderId = serializers.deserialize(value,
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
      'senderId',
      serializers.serialize(object.senderId,
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
        case 'senderId':
          result.senderId = serializers.deserialize(value,
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
      'senderId',
      serializers.serialize(object.senderId,
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
        case 'senderId':
          result.senderId = serializers.deserialize(value,
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

class _$GSearchUsersDataSerializer
    implements StructuredSerializer<GSearchUsersData> {
  @override
  final Iterable<Type> types = const [GSearchUsersData, _$GSearchUsersData];
  @override
  final String wireName = 'GSearchUsersData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GSearchUsersData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'searchUsers',
      serializers.serialize(object.searchUsers,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GSearchUsersData_searchUsers)])),
    ];

    return result;
  }

  @override
  GSearchUsersData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchUsersDataBuilder();

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
        case 'searchUsers':
          result.searchUsers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GSearchUsersData_searchUsers)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchUsersData_searchUsersSerializer
    implements StructuredSerializer<GSearchUsersData_searchUsers> {
  @override
  final Iterable<Type> types = const [
    GSearchUsersData_searchUsers,
    _$GSearchUsersData_searchUsers
  ];
  @override
  final String wireName = 'GSearchUsersData_searchUsers';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSearchUsersData_searchUsers object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'isOnline',
      serializers.serialize(object.isOnline,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phoneNumber')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GSearchUsersData_searchUsers deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSearchUsersData_searchUsersBuilder();

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
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'phoneNumber':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isOnline':
          result.isOnline = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendCallSignalDataSerializer
    implements StructuredSerializer<GSendCallSignalData> {
  @override
  final Iterable<Type> types = const [
    GSendCallSignalData,
    _$GSendCallSignalData
  ];
  @override
  final String wireName = 'GSendCallSignalData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSendCallSignalData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'sendCallSignal',
      serializers.serialize(object.sendCallSignal,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GSendCallSignalData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GSendCallSignalDataBuilder();

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
        case 'sendCallSignal':
          result.sendCallSignal = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GListenToCallSignalsDataSerializer
    implements StructuredSerializer<GListenToCallSignalsData> {
  @override
  final Iterable<Type> types = const [
    GListenToCallSignalsData,
    _$GListenToCallSignalsData
  ];
  @override
  final String wireName = 'GListenToCallSignalsData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GListenToCallSignalsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'callSignals',
      serializers.serialize(object.callSignals,
          specifiedType: const FullType(GListenToCallSignalsData_callSignals)),
    ];

    return result;
  }

  @override
  GListenToCallSignalsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GListenToCallSignalsDataBuilder();

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
        case 'callSignals':
          result.callSignals.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GListenToCallSignalsData_callSignals))!
              as GListenToCallSignalsData_callSignals);
          break;
      }
    }

    return result.build();
  }
}

class _$GListenToCallSignalsData_callSignalsSerializer
    implements StructuredSerializer<GListenToCallSignalsData_callSignals> {
  @override
  final Iterable<Type> types = const [
    GListenToCallSignalsData_callSignals,
    _$GListenToCallSignalsData_callSignals
  ];
  @override
  final String wireName = 'GListenToCallSignalsData_callSignals';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GListenToCallSignalsData_callSignals object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'roomId',
      serializers.serialize(object.roomId,
          specifiedType: const FullType(String)),
      'senderId',
      serializers.serialize(object.senderId,
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
  GListenToCallSignalsData_callSignals deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GListenToCallSignalsData_callSignalsBuilder();

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
        case 'roomId':
          result.roomId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'senderId':
          result.senderId = serializers.deserialize(value,
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

class _$GAskAssistantDataSerializer
    implements StructuredSerializer<GAskAssistantData> {
  @override
  final Iterable<Type> types = const [GAskAssistantData, _$GAskAssistantData];
  @override
  final String wireName = 'GAskAssistantData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GAskAssistantData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'askAssistant',
      serializers.serialize(object.askAssistant,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GAskAssistantData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAskAssistantDataBuilder();

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
        case 'askAssistant':
          result.askAssistant = serializers.deserialize(value,
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
  final BuiltList<GFetchChatHistoryData_messages> messages;

  factory _$GFetchChatHistoryData(
          [void Function(GFetchChatHistoryDataBuilder)? updates]) =>
      (new GFetchChatHistoryDataBuilder()..update(updates))._build();

  _$GFetchChatHistoryData._({required this.G__typename, required this.messages})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GFetchChatHistoryData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        messages, r'GFetchChatHistoryData', 'messages');
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
      _messages = $v.messages.toBuilder();
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
              messages: messages.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messages';
        messages.build();
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
  final String senderId;
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
      required this.senderId,
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
        senderId, r'GFetchChatHistoryData_messages', 'senderId');
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
        senderId == other.senderId &&
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
    _$hash = $jc(_$hash, senderId.hashCode);
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
          ..add('senderId', senderId)
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

  String? _senderId;
  String? get senderId => _$this._senderId;
  set senderId(String? senderId) => _$this._senderId = senderId;

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
      _senderId = $v.senderId;
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
            senderId: BuiltValueNullFieldError.checkNotNull(
                senderId, r'GFetchChatHistoryData_messages', 'senderId'),
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
  final String senderId;
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
      required this.senderId,
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
        senderId, r'GsendMessageData_postMessage', 'senderId');
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
        senderId == other.senderId &&
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
    _$hash = $jc(_$hash, senderId.hashCode);
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
          ..add('senderId', senderId)
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

  String? _senderId;
  String? get senderId => _$this._senderId;
  set senderId(String? senderId) => _$this._senderId = senderId;

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
      _senderId = $v.senderId;
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
            senderId: BuiltValueNullFieldError.checkNotNull(
                senderId, r'GsendMessageData_postMessage', 'senderId'),
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
  final String senderId;
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
      required this.senderId,
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
        senderId, r'GListenToChatData_messages', 'senderId');
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
        senderId == other.senderId &&
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
    _$hash = $jc(_$hash, senderId.hashCode);
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
          ..add('senderId', senderId)
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

  String? _senderId;
  String? get senderId => _$this._senderId;
  set senderId(String? senderId) => _$this._senderId = senderId;

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
      _senderId = $v.senderId;
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
            senderId: BuiltValueNullFieldError.checkNotNull(
                senderId, r'GListenToChatData_messages', 'senderId'),
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

class _$GSearchUsersData extends GSearchUsersData {
  @override
  final String G__typename;
  @override
  final BuiltList<GSearchUsersData_searchUsers> searchUsers;

  factory _$GSearchUsersData(
          [void Function(GSearchUsersDataBuilder)? updates]) =>
      (new GSearchUsersDataBuilder()..update(updates))._build();

  _$GSearchUsersData._({required this.G__typename, required this.searchUsers})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSearchUsersData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        searchUsers, r'GSearchUsersData', 'searchUsers');
  }

  @override
  GSearchUsersData rebuild(void Function(GSearchUsersDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchUsersDataBuilder toBuilder() =>
      new GSearchUsersDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchUsersData &&
        G__typename == other.G__typename &&
        searchUsers == other.searchUsers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, searchUsers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchUsersData')
          ..add('G__typename', G__typename)
          ..add('searchUsers', searchUsers))
        .toString();
  }
}

class GSearchUsersDataBuilder
    implements Builder<GSearchUsersData, GSearchUsersDataBuilder> {
  _$GSearchUsersData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GSearchUsersData_searchUsers>? _searchUsers;
  ListBuilder<GSearchUsersData_searchUsers> get searchUsers =>
      _$this._searchUsers ??= new ListBuilder<GSearchUsersData_searchUsers>();
  set searchUsers(ListBuilder<GSearchUsersData_searchUsers>? searchUsers) =>
      _$this._searchUsers = searchUsers;

  GSearchUsersDataBuilder() {
    GSearchUsersData._initializeBuilder(this);
  }

  GSearchUsersDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _searchUsers = $v.searchUsers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchUsersData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchUsersData;
  }

  @override
  void update(void Function(GSearchUsersDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchUsersData build() => _build();

  _$GSearchUsersData _build() {
    _$GSearchUsersData _$result;
    try {
      _$result = _$v ??
          new _$GSearchUsersData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GSearchUsersData', 'G__typename'),
              searchUsers: searchUsers.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'searchUsers';
        searchUsers.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GSearchUsersData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchUsersData_searchUsers extends GSearchUsersData_searchUsers {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String username;
  @override
  final String? phoneNumber;
  @override
  final bool isOnline;

  factory _$GSearchUsersData_searchUsers(
          [void Function(GSearchUsersData_searchUsersBuilder)? updates]) =>
      (new GSearchUsersData_searchUsersBuilder()..update(updates))._build();

  _$GSearchUsersData_searchUsers._(
      {required this.G__typename,
      required this.id,
      required this.username,
      this.phoneNumber,
      required this.isOnline})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSearchUsersData_searchUsers', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GSearchUsersData_searchUsers', 'id');
    BuiltValueNullFieldError.checkNotNull(
        username, r'GSearchUsersData_searchUsers', 'username');
    BuiltValueNullFieldError.checkNotNull(
        isOnline, r'GSearchUsersData_searchUsers', 'isOnline');
  }

  @override
  GSearchUsersData_searchUsers rebuild(
          void Function(GSearchUsersData_searchUsersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchUsersData_searchUsersBuilder toBuilder() =>
      new GSearchUsersData_searchUsersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchUsersData_searchUsers &&
        G__typename == other.G__typename &&
        id == other.id &&
        username == other.username &&
        phoneNumber == other.phoneNumber &&
        isOnline == other.isOnline;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, isOnline.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchUsersData_searchUsers')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('username', username)
          ..add('phoneNumber', phoneNumber)
          ..add('isOnline', isOnline))
        .toString();
  }
}

class GSearchUsersData_searchUsersBuilder
    implements
        Builder<GSearchUsersData_searchUsers,
            GSearchUsersData_searchUsersBuilder> {
  _$GSearchUsersData_searchUsers? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  bool? _isOnline;
  bool? get isOnline => _$this._isOnline;
  set isOnline(bool? isOnline) => _$this._isOnline = isOnline;

  GSearchUsersData_searchUsersBuilder() {
    GSearchUsersData_searchUsers._initializeBuilder(this);
  }

  GSearchUsersData_searchUsersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _username = $v.username;
      _phoneNumber = $v.phoneNumber;
      _isOnline = $v.isOnline;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchUsersData_searchUsers other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSearchUsersData_searchUsers;
  }

  @override
  void update(void Function(GSearchUsersData_searchUsersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchUsersData_searchUsers build() => _build();

  _$GSearchUsersData_searchUsers _build() {
    final _$result = _$v ??
        new _$GSearchUsersData_searchUsers._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GSearchUsersData_searchUsers', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GSearchUsersData_searchUsers', 'id'),
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'GSearchUsersData_searchUsers', 'username'),
            phoneNumber: phoneNumber,
            isOnline: BuiltValueNullFieldError.checkNotNull(
                isOnline, r'GSearchUsersData_searchUsers', 'isOnline'));
    replace(_$result);
    return _$result;
  }
}

class _$GSendCallSignalData extends GSendCallSignalData {
  @override
  final String G__typename;
  @override
  final bool sendCallSignal;

  factory _$GSendCallSignalData(
          [void Function(GSendCallSignalDataBuilder)? updates]) =>
      (new GSendCallSignalDataBuilder()..update(updates))._build();

  _$GSendCallSignalData._(
      {required this.G__typename, required this.sendCallSignal})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GSendCallSignalData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        sendCallSignal, r'GSendCallSignalData', 'sendCallSignal');
  }

  @override
  GSendCallSignalData rebuild(
          void Function(GSendCallSignalDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendCallSignalDataBuilder toBuilder() =>
      new GSendCallSignalDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendCallSignalData &&
        G__typename == other.G__typename &&
        sendCallSignal == other.sendCallSignal;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, sendCallSignal.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendCallSignalData')
          ..add('G__typename', G__typename)
          ..add('sendCallSignal', sendCallSignal))
        .toString();
  }
}

class GSendCallSignalDataBuilder
    implements Builder<GSendCallSignalData, GSendCallSignalDataBuilder> {
  _$GSendCallSignalData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _sendCallSignal;
  bool? get sendCallSignal => _$this._sendCallSignal;
  set sendCallSignal(bool? sendCallSignal) =>
      _$this._sendCallSignal = sendCallSignal;

  GSendCallSignalDataBuilder() {
    GSendCallSignalData._initializeBuilder(this);
  }

  GSendCallSignalDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _sendCallSignal = $v.sendCallSignal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendCallSignalData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GSendCallSignalData;
  }

  @override
  void update(void Function(GSendCallSignalDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendCallSignalData build() => _build();

  _$GSendCallSignalData _build() {
    final _$result = _$v ??
        new _$GSendCallSignalData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GSendCallSignalData', 'G__typename'),
            sendCallSignal: BuiltValueNullFieldError.checkNotNull(
                sendCallSignal, r'GSendCallSignalData', 'sendCallSignal'));
    replace(_$result);
    return _$result;
  }
}

class _$GListenToCallSignalsData extends GListenToCallSignalsData {
  @override
  final String G__typename;
  @override
  final GListenToCallSignalsData_callSignals callSignals;

  factory _$GListenToCallSignalsData(
          [void Function(GListenToCallSignalsDataBuilder)? updates]) =>
      (new GListenToCallSignalsDataBuilder()..update(updates))._build();

  _$GListenToCallSignalsData._(
      {required this.G__typename, required this.callSignals})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GListenToCallSignalsData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        callSignals, r'GListenToCallSignalsData', 'callSignals');
  }

  @override
  GListenToCallSignalsData rebuild(
          void Function(GListenToCallSignalsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListenToCallSignalsDataBuilder toBuilder() =>
      new GListenToCallSignalsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListenToCallSignalsData &&
        G__typename == other.G__typename &&
        callSignals == other.callSignals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, callSignals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GListenToCallSignalsData')
          ..add('G__typename', G__typename)
          ..add('callSignals', callSignals))
        .toString();
  }
}

class GListenToCallSignalsDataBuilder
    implements
        Builder<GListenToCallSignalsData, GListenToCallSignalsDataBuilder> {
  _$GListenToCallSignalsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GListenToCallSignalsData_callSignalsBuilder? _callSignals;
  GListenToCallSignalsData_callSignalsBuilder get callSignals =>
      _$this._callSignals ??= new GListenToCallSignalsData_callSignalsBuilder();
  set callSignals(GListenToCallSignalsData_callSignalsBuilder? callSignals) =>
      _$this._callSignals = callSignals;

  GListenToCallSignalsDataBuilder() {
    GListenToCallSignalsData._initializeBuilder(this);
  }

  GListenToCallSignalsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _callSignals = $v.callSignals.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GListenToCallSignalsData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GListenToCallSignalsData;
  }

  @override
  void update(void Function(GListenToCallSignalsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GListenToCallSignalsData build() => _build();

  _$GListenToCallSignalsData _build() {
    _$GListenToCallSignalsData _$result;
    try {
      _$result = _$v ??
          new _$GListenToCallSignalsData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GListenToCallSignalsData', 'G__typename'),
              callSignals: callSignals.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'callSignals';
        callSignals.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GListenToCallSignalsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GListenToCallSignalsData_callSignals
    extends GListenToCallSignalsData_callSignals {
  @override
  final String G__typename;
  @override
  final String roomId;
  @override
  final String senderId;
  @override
  final _i2.GCallSignalType type;
  @override
  final String payload;

  factory _$GListenToCallSignalsData_callSignals(
          [void Function(GListenToCallSignalsData_callSignalsBuilder)?
              updates]) =>
      (new GListenToCallSignalsData_callSignalsBuilder()..update(updates))
          ._build();

  _$GListenToCallSignalsData_callSignals._(
      {required this.G__typename,
      required this.roomId,
      required this.senderId,
      required this.type,
      required this.payload})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GListenToCallSignalsData_callSignals', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        roomId, r'GListenToCallSignalsData_callSignals', 'roomId');
    BuiltValueNullFieldError.checkNotNull(
        senderId, r'GListenToCallSignalsData_callSignals', 'senderId');
    BuiltValueNullFieldError.checkNotNull(
        type, r'GListenToCallSignalsData_callSignals', 'type');
    BuiltValueNullFieldError.checkNotNull(
        payload, r'GListenToCallSignalsData_callSignals', 'payload');
  }

  @override
  GListenToCallSignalsData_callSignals rebuild(
          void Function(GListenToCallSignalsData_callSignalsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListenToCallSignalsData_callSignalsBuilder toBuilder() =>
      new GListenToCallSignalsData_callSignalsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListenToCallSignalsData_callSignals &&
        G__typename == other.G__typename &&
        roomId == other.roomId &&
        senderId == other.senderId &&
        type == other.type &&
        payload == other.payload;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, roomId.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, payload.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GListenToCallSignalsData_callSignals')
          ..add('G__typename', G__typename)
          ..add('roomId', roomId)
          ..add('senderId', senderId)
          ..add('type', type)
          ..add('payload', payload))
        .toString();
  }
}

class GListenToCallSignalsData_callSignalsBuilder
    implements
        Builder<GListenToCallSignalsData_callSignals,
            GListenToCallSignalsData_callSignalsBuilder> {
  _$GListenToCallSignalsData_callSignals? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  String? _senderId;
  String? get senderId => _$this._senderId;
  set senderId(String? senderId) => _$this._senderId = senderId;

  _i2.GCallSignalType? _type;
  _i2.GCallSignalType? get type => _$this._type;
  set type(_i2.GCallSignalType? type) => _$this._type = type;

  String? _payload;
  String? get payload => _$this._payload;
  set payload(String? payload) => _$this._payload = payload;

  GListenToCallSignalsData_callSignalsBuilder() {
    GListenToCallSignalsData_callSignals._initializeBuilder(this);
  }

  GListenToCallSignalsData_callSignalsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _roomId = $v.roomId;
      _senderId = $v.senderId;
      _type = $v.type;
      _payload = $v.payload;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GListenToCallSignalsData_callSignals other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GListenToCallSignalsData_callSignals;
  }

  @override
  void update(
      void Function(GListenToCallSignalsData_callSignalsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GListenToCallSignalsData_callSignals build() => _build();

  _$GListenToCallSignalsData_callSignals _build() {
    final _$result = _$v ??
        new _$GListenToCallSignalsData_callSignals._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GListenToCallSignalsData_callSignals', 'G__typename'),
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'GListenToCallSignalsData_callSignals', 'roomId'),
            senderId: BuiltValueNullFieldError.checkNotNull(
                senderId, r'GListenToCallSignalsData_callSignals', 'senderId'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'GListenToCallSignalsData_callSignals', 'type'),
            payload: BuiltValueNullFieldError.checkNotNull(
                payload, r'GListenToCallSignalsData_callSignals', 'payload'));
    replace(_$result);
    return _$result;
  }
}

class _$GAskAssistantData extends GAskAssistantData {
  @override
  final String G__typename;
  @override
  final String askAssistant;

  factory _$GAskAssistantData(
          [void Function(GAskAssistantDataBuilder)? updates]) =>
      (new GAskAssistantDataBuilder()..update(updates))._build();

  _$GAskAssistantData._({required this.G__typename, required this.askAssistant})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GAskAssistantData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        askAssistant, r'GAskAssistantData', 'askAssistant');
  }

  @override
  GAskAssistantData rebuild(void Function(GAskAssistantDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAskAssistantDataBuilder toBuilder() =>
      new GAskAssistantDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAskAssistantData &&
        G__typename == other.G__typename &&
        askAssistant == other.askAssistant;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, askAssistant.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAskAssistantData')
          ..add('G__typename', G__typename)
          ..add('askAssistant', askAssistant))
        .toString();
  }
}

class GAskAssistantDataBuilder
    implements Builder<GAskAssistantData, GAskAssistantDataBuilder> {
  _$GAskAssistantData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _askAssistant;
  String? get askAssistant => _$this._askAssistant;
  set askAssistant(String? askAssistant) => _$this._askAssistant = askAssistant;

  GAskAssistantDataBuilder() {
    GAskAssistantData._initializeBuilder(this);
  }

  GAskAssistantDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _askAssistant = $v.askAssistant;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAskAssistantData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAskAssistantData;
  }

  @override
  void update(void Function(GAskAssistantDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAskAssistantData build() => _build();

  _$GAskAssistantData _build() {
    final _$result = _$v ??
        new _$GAskAssistantData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GAskAssistantData', 'G__typename'),
            askAssistant: BuiltValueNullFieldError.checkNotNull(
                askAssistant, r'GAskAssistantData', 'askAssistant'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
