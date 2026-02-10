// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
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
  BuiltList<GFetchChatHistoryData_messages>? get messages;
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
  String get user;
  String get text;
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
  String get postMessage;
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
  BuiltList<GListenToChatData_messages>? get messages;
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
  String get user;
  String get text;
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
