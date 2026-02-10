// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(FetchPolicy.serializer)
      ..add(GFetchChatHistoryData.serializer)
      ..add(GFetchChatHistoryData_messages.serializer)
      ..add(GFetchChatHistoryReq.serializer)
      ..add(GFetchChatHistoryVars.serializer)
      ..add(GListenToChatData.serializer)
      ..add(GListenToChatData_messages.serializer)
      ..add(GListenToChatReq.serializer)
      ..add(GListenToChatVars.serializer)
      ..add(GsendMessageData.serializer)
      ..add(GsendMessageReq.serializer)
      ..add(GsendMessageVars.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(GFetchChatHistoryData_messages)]),
          () => new ListBuilder<GFetchChatHistoryData_messages>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(GListenToChatData_messages)]),
          () => new ListBuilder<GListenToChatData_messages>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
