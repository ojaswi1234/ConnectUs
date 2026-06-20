// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ConnectUs/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:ConnectUs/graphql/__generated__/serializers.gql.dart' as _i1;

part 'operations.data.gql.g.dart';

abstract class GFetchChatHistoryData
    implements Built<GFetchChatHistoryData, GFetchChatHistoryDataBuilder> {
  GFetchChatHistoryData._();

  factory GFetchChatHistoryData(
          [void Function(GFetchChatHistoryDataBuilder b) updates]) =
      _$GFetchChatHistoryData;

  static void _initializeBuilder(GFetchChatHistoryDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GFetchChatHistoryData_messages> get messages;
  static Serializer<GFetchChatHistoryData> get serializer =>
      _$gFetchChatHistoryDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFetchChatHistoryData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFetchChatHistoryData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFetchChatHistoryData.serializer,
        json,
      );
}

abstract class GFetchChatHistoryData_messages
    implements
        Built<GFetchChatHistoryData_messages,
            GFetchChatHistoryData_messagesBuilder> {
  GFetchChatHistoryData_messages._();

  factory GFetchChatHistoryData_messages(
          [void Function(GFetchChatHistoryData_messagesBuilder b) updates]) =
      _$GFetchChatHistoryData_messages;

  static void _initializeBuilder(GFetchChatHistoryData_messagesBuilder b) =>
      b..G__typename = 'Message';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get roomId;
  String get senderId;
  String get user;
  String get text;
  String get createdAt;
  static Serializer<GFetchChatHistoryData_messages> get serializer =>
      _$gFetchChatHistoryDataMessagesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFetchChatHistoryData_messages.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFetchChatHistoryData_messages? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFetchChatHistoryData_messages.serializer,
        json,
      );
}

abstract class GsendMessageData
    implements Built<GsendMessageData, GsendMessageDataBuilder> {
  GsendMessageData._();

  factory GsendMessageData([void Function(GsendMessageDataBuilder b) updates]) =
      _$GsendMessageData;

  static void _initializeBuilder(GsendMessageDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GsendMessageData_postMessage get postMessage;
  static Serializer<GsendMessageData> get serializer =>
      _$gsendMessageDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GsendMessageData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GsendMessageData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GsendMessageData.serializer,
        json,
      );
}

abstract class GsendMessageData_postMessage
    implements
        Built<GsendMessageData_postMessage,
            GsendMessageData_postMessageBuilder> {
  GsendMessageData_postMessage._();

  factory GsendMessageData_postMessage(
          [void Function(GsendMessageData_postMessageBuilder b) updates]) =
      _$GsendMessageData_postMessage;

  static void _initializeBuilder(GsendMessageData_postMessageBuilder b) =>
      b..G__typename = 'Message';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get roomId;
  String get senderId;
  String get user;
  String get text;
  String get createdAt;
  static Serializer<GsendMessageData_postMessage> get serializer =>
      _$gsendMessageDataPostMessageSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GsendMessageData_postMessage.serializer,
        this,
      ) as Map<String, dynamic>);

  static GsendMessageData_postMessage? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GsendMessageData_postMessage.serializer,
        json,
      );
}

abstract class GListenToChatData
    implements Built<GListenToChatData, GListenToChatDataBuilder> {
  GListenToChatData._();

  factory GListenToChatData(
          [void Function(GListenToChatDataBuilder b) updates]) =
      _$GListenToChatData;

  static void _initializeBuilder(GListenToChatDataBuilder b) =>
      b..G__typename = 'Subscription';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GListenToChatData_messages get messages;
  static Serializer<GListenToChatData> get serializer =>
      _$gListenToChatDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListenToChatData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListenToChatData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListenToChatData.serializer,
        json,
      );
}

abstract class GListenToChatData_messages
    implements
        Built<GListenToChatData_messages, GListenToChatData_messagesBuilder> {
  GListenToChatData_messages._();

  factory GListenToChatData_messages(
          [void Function(GListenToChatData_messagesBuilder b) updates]) =
      _$GListenToChatData_messages;

  static void _initializeBuilder(GListenToChatData_messagesBuilder b) =>
      b..G__typename = 'Message';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get roomId;
  String get senderId;
  String get user;
  String get text;
  String get createdAt;
  static Serializer<GListenToChatData_messages> get serializer =>
      _$gListenToChatDataMessagesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListenToChatData_messages.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListenToChatData_messages? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListenToChatData_messages.serializer,
        json,
      );
}

abstract class GSearchUsersData
    implements Built<GSearchUsersData, GSearchUsersDataBuilder> {
  GSearchUsersData._();

  factory GSearchUsersData([void Function(GSearchUsersDataBuilder b) updates]) =
      _$GSearchUsersData;

  static void _initializeBuilder(GSearchUsersDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GSearchUsersData_searchUsers> get searchUsers;
  static Serializer<GSearchUsersData> get serializer =>
      _$gSearchUsersDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchUsersData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchUsersData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchUsersData.serializer,
        json,
      );
}

abstract class GSearchUsersData_searchUsers
    implements
        Built<GSearchUsersData_searchUsers,
            GSearchUsersData_searchUsersBuilder> {
  GSearchUsersData_searchUsers._();

  factory GSearchUsersData_searchUsers(
          [void Function(GSearchUsersData_searchUsersBuilder b) updates]) =
      _$GSearchUsersData_searchUsers;

  static void _initializeBuilder(GSearchUsersData_searchUsersBuilder b) =>
      b..G__typename = 'UserSearchResult';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get username;
  String? get phoneNumber;
  bool get isOnline;
  static Serializer<GSearchUsersData_searchUsers> get serializer =>
      _$gSearchUsersDataSearchUsersSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchUsersData_searchUsers.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchUsersData_searchUsers? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchUsersData_searchUsers.serializer,
        json,
      );
}

abstract class GSendCallSignalData
    implements Built<GSendCallSignalData, GSendCallSignalDataBuilder> {
  GSendCallSignalData._();

  factory GSendCallSignalData(
          [void Function(GSendCallSignalDataBuilder b) updates]) =
      _$GSendCallSignalData;

  static void _initializeBuilder(GSendCallSignalDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get sendCallSignal;
  static Serializer<GSendCallSignalData> get serializer =>
      _$gSendCallSignalDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendCallSignalData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendCallSignalData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendCallSignalData.serializer,
        json,
      );
}

abstract class GListenToCallSignalsData
    implements
        Built<GListenToCallSignalsData, GListenToCallSignalsDataBuilder> {
  GListenToCallSignalsData._();

  factory GListenToCallSignalsData(
          [void Function(GListenToCallSignalsDataBuilder b) updates]) =
      _$GListenToCallSignalsData;

  static void _initializeBuilder(GListenToCallSignalsDataBuilder b) =>
      b..G__typename = 'Subscription';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GListenToCallSignalsData_callSignals get callSignals;
  static Serializer<GListenToCallSignalsData> get serializer =>
      _$gListenToCallSignalsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListenToCallSignalsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListenToCallSignalsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListenToCallSignalsData.serializer,
        json,
      );
}

abstract class GListenToCallSignalsData_callSignals
    implements
        Built<GListenToCallSignalsData_callSignals,
            GListenToCallSignalsData_callSignalsBuilder> {
  GListenToCallSignalsData_callSignals._();

  factory GListenToCallSignalsData_callSignals(
      [void Function(GListenToCallSignalsData_callSignalsBuilder b)
          updates]) = _$GListenToCallSignalsData_callSignals;

  static void _initializeBuilder(
          GListenToCallSignalsData_callSignalsBuilder b) =>
      b..G__typename = 'CallSignal';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get roomId;
  String get senderId;
  _i2.GCallSignalType get type;
  String get payload;
  static Serializer<GListenToCallSignalsData_callSignals> get serializer =>
      _$gListenToCallSignalsDataCallSignalsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListenToCallSignalsData_callSignals.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListenToCallSignalsData_callSignals? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListenToCallSignalsData_callSignals.serializer,
        json,
      );
}

abstract class GAskAssistantData
    implements Built<GAskAssistantData, GAskAssistantDataBuilder> {
  GAskAssistantData._();

  factory GAskAssistantData(
          [void Function(GAskAssistantDataBuilder b) updates]) =
      _$GAskAssistantData;

  static void _initializeBuilder(GAskAssistantDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get askAssistant;
  static Serializer<GAskAssistantData> get serializer =>
      _$gAskAssistantDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAskAssistantData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAskAssistantData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAskAssistantData.serializer,
        json,
      );
}
