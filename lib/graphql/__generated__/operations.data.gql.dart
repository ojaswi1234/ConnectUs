// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ConnectUs/graphql/__generated__/serializers.gql.dart' as _i1;

part 'operations.data.gql.g.dart';

abstract class GGetMessagesData
    implements Built<GGetMessagesData, GGetMessagesDataBuilder> {
  GGetMessagesData._();

  factory GGetMessagesData([void Function(GGetMessagesDataBuilder b) updates]) =
      _$GGetMessagesData;

  static void _initializeBuilder(GGetMessagesDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetMessagesData_messages> get messages;
  static Serializer<GGetMessagesData> get serializer =>
      _$gGetMessagesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesData.serializer,
        json,
      );
}

abstract class GGetMessagesData_messages
    implements
        Built<GGetMessagesData_messages, GGetMessagesData_messagesBuilder>,
        GChatMessageFields {
  GGetMessagesData_messages._();

  factory GGetMessagesData_messages(
          [void Function(GGetMessagesData_messagesBuilder b) updates]) =
      _$GGetMessagesData_messages;

  static void _initializeBuilder(GGetMessagesData_messagesBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get roomId;
  @override
  String get user;
  @override
  String get to;
  @override
  String get content;
  @override
  String get createdAt;
  static Serializer<GGetMessagesData_messages> get serializer =>
      _$gGetMessagesDataMessagesSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesData_messages.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesData_messages? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesData_messages.serializer,
        json,
      );
}

abstract class GPostMessageData
    implements Built<GPostMessageData, GPostMessageDataBuilder> {
  GPostMessageData._();

  factory GPostMessageData([void Function(GPostMessageDataBuilder b) updates]) =
      _$GPostMessageData;

  static void _initializeBuilder(GPostMessageDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GPostMessageData_postMessage get postMessage;
  static Serializer<GPostMessageData> get serializer =>
      _$gPostMessageDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostMessageData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostMessageData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostMessageData.serializer,
        json,
      );
}

abstract class GPostMessageData_postMessage
    implements
        Built<GPostMessageData_postMessage,
            GPostMessageData_postMessageBuilder>,
        GChatMessageFields {
  GPostMessageData_postMessage._();

  factory GPostMessageData_postMessage(
          [void Function(GPostMessageData_postMessageBuilder b) updates]) =
      _$GPostMessageData_postMessage;

  static void _initializeBuilder(GPostMessageData_postMessageBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get roomId;
  @override
  String get user;
  @override
  String get to;
  @override
  String get content;
  @override
  String get createdAt;
  static Serializer<GPostMessageData_postMessage> get serializer =>
      _$gPostMessageDataPostMessageSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostMessageData_postMessage.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostMessageData_postMessage? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostMessageData_postMessage.serializer,
        json,
      );
}

abstract class GOnNewMessageData
    implements Built<GOnNewMessageData, GOnNewMessageDataBuilder> {
  GOnNewMessageData._();

  factory GOnNewMessageData(
          [void Function(GOnNewMessageDataBuilder b) updates]) =
      _$GOnNewMessageData;

  static void _initializeBuilder(GOnNewMessageDataBuilder b) =>
      b..G__typename = 'Subscription';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GOnNewMessageData_messageAdded get messageAdded;
  static Serializer<GOnNewMessageData> get serializer =>
      _$gOnNewMessageDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOnNewMessageData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOnNewMessageData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOnNewMessageData.serializer,
        json,
      );
}

abstract class GOnNewMessageData_messageAdded
    implements
        Built<GOnNewMessageData_messageAdded,
            GOnNewMessageData_messageAddedBuilder>,
        GChatMessageFields {
  GOnNewMessageData_messageAdded._();

  factory GOnNewMessageData_messageAdded(
          [void Function(GOnNewMessageData_messageAddedBuilder b) updates]) =
      _$GOnNewMessageData_messageAdded;

  static void _initializeBuilder(GOnNewMessageData_messageAddedBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get roomId;
  @override
  String get user;
  @override
  String get to;
  @override
  String get content;
  @override
  String get createdAt;
  static Serializer<GOnNewMessageData_messageAdded> get serializer =>
      _$gOnNewMessageDataMessageAddedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOnNewMessageData_messageAdded.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOnNewMessageData_messageAdded? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOnNewMessageData_messageAdded.serializer,
        json,
      );
}

abstract class GListenToIncomingMessagesData
    implements
        Built<GListenToIncomingMessagesData,
            GListenToIncomingMessagesDataBuilder> {
  GListenToIncomingMessagesData._();

  factory GListenToIncomingMessagesData(
          [void Function(GListenToIncomingMessagesDataBuilder b) updates]) =
      _$GListenToIncomingMessagesData;

  static void _initializeBuilder(GListenToIncomingMessagesDataBuilder b) =>
      b..G__typename = 'Subscription';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GListenToIncomingMessagesData_messageSentToUser get messageSentToUser;
  static Serializer<GListenToIncomingMessagesData> get serializer =>
      _$gListenToIncomingMessagesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListenToIncomingMessagesData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListenToIncomingMessagesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListenToIncomingMessagesData.serializer,
        json,
      );
}

abstract class GListenToIncomingMessagesData_messageSentToUser
    implements
        Built<GListenToIncomingMessagesData_messageSentToUser,
            GListenToIncomingMessagesData_messageSentToUserBuilder>,
        GChatMessageFields {
  GListenToIncomingMessagesData_messageSentToUser._();

  factory GListenToIncomingMessagesData_messageSentToUser(
      [void Function(GListenToIncomingMessagesData_messageSentToUserBuilder b)
          updates]) = _$GListenToIncomingMessagesData_messageSentToUser;

  static void _initializeBuilder(
          GListenToIncomingMessagesData_messageSentToUserBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get roomId;
  @override
  String get user;
  @override
  String get to;
  @override
  String get content;
  @override
  String get createdAt;
  static Serializer<GListenToIncomingMessagesData_messageSentToUser>
      get serializer =>
          _$gListenToIncomingMessagesDataMessageSentToUserSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListenToIncomingMessagesData_messageSentToUser.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListenToIncomingMessagesData_messageSentToUser? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListenToIncomingMessagesData_messageSentToUser.serializer,
        json,
      );
}

abstract class GGetMyChatsData
    implements Built<GGetMyChatsData, GGetMyChatsDataBuilder> {
  GGetMyChatsData._();

  factory GGetMyChatsData([void Function(GGetMyChatsDataBuilder b) updates]) =
      _$GGetMyChatsData;

  static void _initializeBuilder(GGetMyChatsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetMyChatsData_user_chats_view> get user_chats_view;
  static Serializer<GGetMyChatsData> get serializer =>
      _$gGetMyChatsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMyChatsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMyChatsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMyChatsData.serializer,
        json,
      );
}

abstract class GGetMyChatsData_user_chats_view
    implements
        Built<GGetMyChatsData_user_chats_view,
            GGetMyChatsData_user_chats_viewBuilder> {
  GGetMyChatsData_user_chats_view._();

  factory GGetMyChatsData_user_chats_view(
          [void Function(GGetMyChatsData_user_chats_viewBuilder b) updates]) =
      _$GGetMyChatsData_user_chats_view;

  static void _initializeBuilder(GGetMyChatsData_user_chats_viewBuilder b) =>
      b..G__typename = 'UserChat';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get room_id;
  String get contact_name;
  String get last_message;
  String get created_at;
  static Serializer<GGetMyChatsData_user_chats_view> get serializer =>
      _$gGetMyChatsDataUserChatsViewSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMyChatsData_user_chats_view.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMyChatsData_user_chats_view? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMyChatsData_user_chats_view.serializer,
        json,
      );
}

abstract class GChatMessageFields {
  String get G__typename;
  String get id;
  String get roomId;
  String get user;
  String get to;
  String get content;
  String get createdAt;
  Map<String, dynamic> toJson();
}

abstract class GChatMessageFieldsData
    implements
        Built<GChatMessageFieldsData, GChatMessageFieldsDataBuilder>,
        GChatMessageFields {
  GChatMessageFieldsData._();

  factory GChatMessageFieldsData(
          [void Function(GChatMessageFieldsDataBuilder b) updates]) =
      _$GChatMessageFieldsData;

  static void _initializeBuilder(GChatMessageFieldsDataBuilder b) =>
      b..G__typename = 'Message';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get roomId;
  @override
  String get user;
  @override
  String get to;
  @override
  String get content;
  @override
  String get createdAt;
  static Serializer<GChatMessageFieldsData> get serializer =>
      _$gChatMessageFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatMessageFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatMessageFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatMessageFieldsData.serializer,
        json,
      );
}
