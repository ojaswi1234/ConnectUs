// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ConnectUs/graphql/__generated__/operations.data.gql.dart'
    show
        GFetchChatHistoryData,
        GFetchChatHistoryData_messages,
        GListenToChatData,
        GListenToChatData_messages,
        GsendMessageData;
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart'
    show GFetchChatHistoryReq, GListenToChatReq, GsendMessageReq;
import 'package:ConnectUs/graphql/__generated__/operations.var.gql.dart'
    show GFetchChatHistoryVars, GListenToChatVars, GsendMessageVars;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GFetchChatHistoryData,
  GFetchChatHistoryData_messages,
  GFetchChatHistoryReq,
  GFetchChatHistoryVars,
  GListenToChatData,
  GListenToChatData_messages,
  GListenToChatReq,
  GListenToChatVars,
  GsendMessageData,
  GsendMessageReq,
  GsendMessageVars,
])
final Serializers serializers = _serializersBuilder.build();
