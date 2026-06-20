// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ConnectUs/graphql/__generated__/operations.data.gql.dart'
    show
        GGetMessagesData,
        GGetMessagesData_messages,
        GListenToChatData,
        GListenToChatData_messages,
        GSendMessageData;
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart'
    show GGetMessagesReq, GListenToChatReq, GSendMessageReq;
import 'package:ConnectUs/graphql/__generated__/operations.var.gql.dart'
    show GGetMessagesVars, GListenToChatVars, GSendMessageVars;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GGetMessagesData,
  GGetMessagesData_messages,
  GGetMessagesReq,
  GGetMessagesVars,
  GListenToChatData,
  GListenToChatData_messages,
  GListenToChatReq,
  GListenToChatVars,
  GSendMessageData,
  GSendMessageReq,
  GSendMessageVars,
])
final Serializers serializers = _serializersBuilder.build();
