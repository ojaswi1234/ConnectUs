// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ConnectUs/graphql/__generated__/serializers.gql.dart' as _i1;

part 'operations.var.gql.g.dart';

abstract class GGetMessagesVars
    implements Built<GGetMessagesVars, GGetMessagesVarsBuilder> {
  GGetMessagesVars._();

  factory GGetMessagesVars([void Function(GGetMessagesVarsBuilder b) updates]) =
      _$GGetMessagesVars;

  String get roomId;
  static Serializer<GGetMessagesVars> get serializer =>
      _$gGetMessagesVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetMessagesVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetMessagesVars.serializer,
        json,
      );
}

abstract class GPostMessageVars
    implements Built<GPostMessageVars, GPostMessageVarsBuilder> {
  GPostMessageVars._();

  factory GPostMessageVars([void Function(GPostMessageVarsBuilder b) updates]) =
      _$GPostMessageVars;

  String get roomId;
  String get user;
  String get content;
  static Serializer<GPostMessageVars> get serializer =>
      _$gPostMessageVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPostMessageVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostMessageVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPostMessageVars.serializer,
        json,
      );
}

abstract class GOnNewMessageVars
    implements Built<GOnNewMessageVars, GOnNewMessageVarsBuilder> {
  GOnNewMessageVars._();

  factory GOnNewMessageVars(
          [void Function(GOnNewMessageVarsBuilder b) updates]) =
      _$GOnNewMessageVars;

  String get roomId;
  static Serializer<GOnNewMessageVars> get serializer =>
      _$gOnNewMessageVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOnNewMessageVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOnNewMessageVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOnNewMessageVars.serializer,
        json,
      );
}

abstract class GChatMessageFieldsVars
    implements Built<GChatMessageFieldsVars, GChatMessageFieldsVarsBuilder> {
  GChatMessageFieldsVars._();

  factory GChatMessageFieldsVars(
          [void Function(GChatMessageFieldsVarsBuilder b) updates]) =
      _$GChatMessageFieldsVars;

  static Serializer<GChatMessageFieldsVars> get serializer =>
      _$gChatMessageFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChatMessageFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChatMessageFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChatMessageFieldsVars.serializer,
        json,
      );
}
