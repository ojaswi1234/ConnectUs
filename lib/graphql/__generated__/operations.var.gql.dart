// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ConnectUs/graphql/__generated__/serializers.gql.dart' as _i1;

part 'operations.var.gql.g.dart';

abstract class GFetchChatHistoryVars
    implements Built<GFetchChatHistoryVars, GFetchChatHistoryVarsBuilder> {
  GFetchChatHistoryVars._();

  factory GFetchChatHistoryVars(
          [void Function(GFetchChatHistoryVarsBuilder b) updates]) =
      _$GFetchChatHistoryVars;

  static Serializer<GFetchChatHistoryVars> get serializer =>
      _$gFetchChatHistoryVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GFetchChatHistoryVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFetchChatHistoryVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GFetchChatHistoryVars.serializer,
        json,
      );
}

abstract class GsendMessageVars
    implements Built<GsendMessageVars, GsendMessageVarsBuilder> {
  GsendMessageVars._();

  factory GsendMessageVars([void Function(GsendMessageVarsBuilder b) updates]) =
      _$GsendMessageVars;

  String get user;
  String get text;
  String get roomId;
  static Serializer<GsendMessageVars> get serializer =>
      _$gsendMessageVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GsendMessageVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GsendMessageVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GsendMessageVars.serializer,
        json,
      );
}

abstract class GListenToChatVars
    implements Built<GListenToChatVars, GListenToChatVarsBuilder> {
  GListenToChatVars._();

  factory GListenToChatVars(
          [void Function(GListenToChatVarsBuilder b) updates]) =
      _$GListenToChatVars;

  static Serializer<GListenToChatVars> get serializer =>
      _$gListenToChatVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListenToChatVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListenToChatVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListenToChatVars.serializer,
        json,
      );
}
