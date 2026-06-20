// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ConnectUs/graphql/__generated__/schema.schema.gql.dart' as _i2;
import 'package:ConnectUs/graphql/__generated__/serializers.gql.dart' as _i1;

part 'operations.var.gql.g.dart';

abstract class GFetchChatHistoryVars
    implements Built<GFetchChatHistoryVars, GFetchChatHistoryVarsBuilder> {
  GFetchChatHistoryVars._();

  factory GFetchChatHistoryVars(
          [void Function(GFetchChatHistoryVarsBuilder b) updates]) =
      _$GFetchChatHistoryVars;

  String get roomId;
  String? get after;
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

  String get roomId;
  String get user;
  String get text;
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

abstract class GSearchUsersVars
    implements Built<GSearchUsersVars, GSearchUsersVarsBuilder> {
  GSearchUsersVars._();

  factory GSearchUsersVars([void Function(GSearchUsersVarsBuilder b) updates]) =
      _$GSearchUsersVars;

  String get query;
  _i2.GPlatform get platform;
  static Serializer<GSearchUsersVars> get serializer =>
      _$gSearchUsersVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSearchUsersVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSearchUsersVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSearchUsersVars.serializer,
        json,
      );
}

abstract class GSendCallSignalVars
    implements Built<GSendCallSignalVars, GSendCallSignalVarsBuilder> {
  GSendCallSignalVars._();

  factory GSendCallSignalVars(
          [void Function(GSendCallSignalVarsBuilder b) updates]) =
      _$GSendCallSignalVars;

  String get roomId;
  _i2.GCallSignalType get type;
  String get payload;
  static Serializer<GSendCallSignalVars> get serializer =>
      _$gSendCallSignalVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendCallSignalVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendCallSignalVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendCallSignalVars.serializer,
        json,
      );
}

abstract class GListenToCallSignalsVars
    implements
        Built<GListenToCallSignalsVars, GListenToCallSignalsVarsBuilder> {
  GListenToCallSignalsVars._();

  factory GListenToCallSignalsVars(
          [void Function(GListenToCallSignalsVarsBuilder b) updates]) =
      _$GListenToCallSignalsVars;

  String get roomId;
  static Serializer<GListenToCallSignalsVars> get serializer =>
      _$gListenToCallSignalsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GListenToCallSignalsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListenToCallSignalsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GListenToCallSignalsVars.serializer,
        json,
      );
}

abstract class GAskAssistantVars
    implements Built<GAskAssistantVars, GAskAssistantVarsBuilder> {
  GAskAssistantVars._();

  factory GAskAssistantVars(
          [void Function(GAskAssistantVarsBuilder b) updates]) =
      _$GAskAssistantVars;

  String get prompt;
  static Serializer<GAskAssistantVars> get serializer =>
      _$gAskAssistantVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAskAssistantVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAskAssistantVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAskAssistantVars.serializer,
        json,
      );
}
