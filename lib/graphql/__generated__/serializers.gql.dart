// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ConnectUs/graphql/__generated__/operations.data.gql.dart'
    show
        GChatMessageFieldsData,
        GGetMessagesData,
        GGetMessagesData_messages,
        GGetMyChatsData,
        GGetMyChatsData_user_chats_view,
        GListenToIncomingMessagesData,
        GListenToIncomingMessagesData_messageSentToUser,
        GOnNewMessageData,
        GOnNewMessageData_messageAdded,
        GPostMessageData,
        GPostMessageData_postMessage;
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart'
    show
        GChatMessageFieldsReq,
        GGetMessagesReq,
        GGetMyChatsReq,
        GListenToIncomingMessagesReq,
        GOnNewMessageReq,
        GPostMessageReq;
import 'package:ConnectUs/graphql/__generated__/operations.var.gql.dart'
    show
        GChatMessageFieldsVars,
        GGetMessagesVars,
        GGetMyChatsVars,
        GListenToIncomingMessagesVars,
        GOnNewMessageVars,
        GPostMessageVars;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GChatMessageFieldsData,
  GChatMessageFieldsReq,
  GChatMessageFieldsVars,
  GGetMessagesData,
  GGetMessagesData_messages,
  GGetMessagesReq,
  GGetMessagesVars,
  GGetMyChatsData,
  GGetMyChatsData_user_chats_view,
  GGetMyChatsReq,
  GGetMyChatsVars,
  GListenToIncomingMessagesData,
  GListenToIncomingMessagesData_messageSentToUser,
  GListenToIncomingMessagesReq,
  GListenToIncomingMessagesVars,
  GOnNewMessageData,
  GOnNewMessageData_messageAdded,
  GOnNewMessageReq,
  GOnNewMessageVars,
  GPostMessageData,
  GPostMessageData_postMessage,
  GPostMessageReq,
  GPostMessageVars,
])
final Serializers serializers = _serializersBuilder.build();
