// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ConnectUs/graphql/__generated__/operations.data.gql.dart'
    show
        GAskAssistantData,
        GFetchChatHistoryData,
        GFetchChatHistoryData_messages,
        GListenToCallSignalsData,
        GListenToCallSignalsData_callSignals,
        GListenToChatData,
        GListenToChatData_messages,
        GSearchUsersData,
        GSearchUsersData_searchUsers,
        GSendCallSignalData,
        GsendMessageData,
        GsendMessageData_postMessage;
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart'
    show
        GAskAssistantReq,
        GFetchChatHistoryReq,
        GListenToCallSignalsReq,
        GListenToChatReq,
        GSearchUsersReq,
        GSendCallSignalReq,
        GsendMessageReq;
import 'package:ConnectUs/graphql/__generated__/operations.var.gql.dart'
    show
        GAskAssistantVars,
        GFetchChatHistoryVars,
        GListenToCallSignalsVars,
        GListenToChatVars,
        GSearchUsersVars,
        GSendCallSignalVars,
        GsendMessageVars;
import 'package:ConnectUs/graphql/__generated__/schema.schema.gql.dart'
    show GCallSignalType, GPlatform;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAskAssistantData,
  GAskAssistantReq,
  GAskAssistantVars,
  GCallSignalType,
  GFetchChatHistoryData,
  GFetchChatHistoryData_messages,
  GFetchChatHistoryReq,
  GFetchChatHistoryVars,
  GListenToCallSignalsData,
  GListenToCallSignalsData_callSignals,
  GListenToCallSignalsReq,
  GListenToCallSignalsVars,
  GListenToChatData,
  GListenToChatData_messages,
  GListenToChatReq,
  GListenToChatVars,
  GPlatform,
  GSearchUsersData,
  GSearchUsersData_searchUsers,
  GSearchUsersReq,
  GSearchUsersVars,
  GSendCallSignalData,
  GSendCallSignalReq,
  GSendCallSignalVars,
  GsendMessageData,
  GsendMessageData_postMessage,
  GsendMessageReq,
  GsendMessageVars,
])
final Serializers serializers = _serializersBuilder.build();
