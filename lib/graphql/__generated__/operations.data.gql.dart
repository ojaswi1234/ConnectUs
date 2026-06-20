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
        Built<GGetMessagesData_messages, GGetMessagesData_messagesBuilder> {
  GGetMessagesData_messages._();

  factory GGetMessagesData_messages(
          [void Function(GGetMessagesData_messagesBuilder b) updates]) =
      _$GGetMessagesData_messages;

  static void _initializeBuilder(GGetMessagesData_messagesBuilder b) =>
      b..G__typename = 'Message';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get user;
  String get text;
  String get roomId;
  String? get createdAt;
  static Serializer<GGetMessagesData_messages> get serializer =>
      _$gGetMessagesDataMessagesSerializer;

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

abstract class GSendMessageData
    implements Built<GSendMessageData, GSendMessageDataBuilder> {
  GSendMessageData._();

  factory GSendMessageData([void Function(GSendMessageDataBuilder b) updates]) =
      _$GSendMessageData;

  static void _initializeBuilder(GSendMessageDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get postMessage;
  static Serializer<GSendMessageData> get serializer =>
      _$gSendMessageDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData.serializer,
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
  BuiltList<GListenToChatData_messages> get messages;
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
  String get user;
  String get text;
  String get roomId;
  String? get createdAt;
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
