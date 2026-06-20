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

abstract class GSendMessageVars
    implements Built<GSendMessageVars, GSendMessageVarsBuilder> {
  GSendMessageVars._();

  factory GSendMessageVars([void Function(GSendMessageVarsBuilder b) updates]) =
      _$GSendMessageVars;

  String get roomId;
  String get user;
  String get text;
  static Serializer<GSendMessageVars> get serializer =>
      _$gSendMessageVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendMessageVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageVars.serializer,
        json,
      );
}

abstract class GListenToChatVars
    implements Built<GListenToChatVars, GListenToChatVarsBuilder> {
  GListenToChatVars._();

  factory GListenToChatVars(
          [void Function(GListenToChatVarsBuilder b) updates]) =
      _$GListenToChatVars;

  String get roomId;
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
