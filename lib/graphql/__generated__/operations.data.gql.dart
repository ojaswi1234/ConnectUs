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
  BuiltList<GGetMessagesData_messages>? get messages;
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
  String get content;
  String get createdAt;
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
            GPostMessageData_postMessageBuilder> {
  GPostMessageData_postMessage._();

  factory GPostMessageData_postMessage(
          [void Function(GPostMessageData_postMessageBuilder b) updates]) =
      _$GPostMessageData_postMessage;

  static void _initializeBuilder(GPostMessageData_postMessageBuilder b) =>
      b..G__typename = 'Message';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get user;
  String get content;
  String get createdAt;
  static Serializer<GPostMessageData_postMessage> get serializer =>
      _$gPostMessageDataPostMessageSerializer;

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
            GOnNewMessageData_messageAddedBuilder> {
  GOnNewMessageData_messageAdded._();

  factory GOnNewMessageData_messageAdded(
          [void Function(GOnNewMessageData_messageAddedBuilder b) updates]) =
      _$GOnNewMessageData_messageAdded;

  static void _initializeBuilder(GOnNewMessageData_messageAddedBuilder b) =>
      b..G__typename = 'Message';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get content;
  String get user;
  String get createdAt;
  static Serializer<GOnNewMessageData_messageAdded> get serializer =>
      _$gOnNewMessageDataMessageAddedSerializer;

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
