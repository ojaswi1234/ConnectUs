// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ConnectUs/graphql/__generated__/operations.ast.gql.dart' as _i5;
import 'package:ConnectUs/graphql/__generated__/operations.data.gql.dart'
    as _i2;
import 'package:ConnectUs/graphql/__generated__/operations.var.gql.dart' as _i3;
import 'package:ConnectUs/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'operations.req.gql.g.dart';

abstract class GFetchChatHistoryReq
    implements
        Built<GFetchChatHistoryReq, GFetchChatHistoryReqBuilder>,
        _i1.OperationRequest<_i2.GFetchChatHistoryData,
            _i3.GFetchChatHistoryVars> {
  GFetchChatHistoryReq._();

  factory GFetchChatHistoryReq(
          [void Function(GFetchChatHistoryReqBuilder b) updates]) =
      _$GFetchChatHistoryReq;

  static void _initializeBuilder(GFetchChatHistoryReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'FetchChatHistory',
    )
    ..executeOnListen = true;

  @override
  _i3.GFetchChatHistoryVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GFetchChatHistoryData? Function(
    _i2.GFetchChatHistoryData?,
    _i2.GFetchChatHistoryData?,
  )? get updateResult;
  @override
  _i2.GFetchChatHistoryData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GFetchChatHistoryData? parseData(Map<String, dynamic> json) =>
      _i2.GFetchChatHistoryData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GFetchChatHistoryData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GFetchChatHistoryData, _i3.GFetchChatHistoryVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GFetchChatHistoryReq> get serializer =>
      _$gFetchChatHistoryReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GFetchChatHistoryReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GFetchChatHistoryReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GFetchChatHistoryReq.serializer,
        json,
      );
}

abstract class GsendMessageReq
    implements
        Built<GsendMessageReq, GsendMessageReqBuilder>,
        _i1.OperationRequest<_i2.GsendMessageData, _i3.GsendMessageVars> {
  GsendMessageReq._();

  factory GsendMessageReq([void Function(GsendMessageReqBuilder b) updates]) =
      _$GsendMessageReq;

  static void _initializeBuilder(GsendMessageReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'sendMessage',
    )
    ..executeOnListen = true;

  @override
  _i3.GsendMessageVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GsendMessageData? Function(
    _i2.GsendMessageData?,
    _i2.GsendMessageData?,
  )? get updateResult;
  @override
  _i2.GsendMessageData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GsendMessageData? parseData(Map<String, dynamic> json) =>
      _i2.GsendMessageData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GsendMessageData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GsendMessageData, _i3.GsendMessageVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GsendMessageReq> get serializer =>
      _$gsendMessageReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GsendMessageReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GsendMessageReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GsendMessageReq.serializer,
        json,
      );
}

abstract class GListenToChatReq
    implements
        Built<GListenToChatReq, GListenToChatReqBuilder>,
        _i1.OperationRequest<_i2.GListenToChatData, _i3.GListenToChatVars> {
  GListenToChatReq._();

  factory GListenToChatReq([void Function(GListenToChatReqBuilder b) updates]) =
      _$GListenToChatReq;

  static void _initializeBuilder(GListenToChatReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ListenToChat',
    )
    ..executeOnListen = true;

  @override
  _i3.GListenToChatVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GListenToChatData? Function(
    _i2.GListenToChatData?,
    _i2.GListenToChatData?,
  )? get updateResult;
  @override
  _i2.GListenToChatData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GListenToChatData? parseData(Map<String, dynamic> json) =>
      _i2.GListenToChatData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GListenToChatData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GListenToChatData, _i3.GListenToChatVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GListenToChatReq> get serializer =>
      _$gListenToChatReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GListenToChatReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GListenToChatReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GListenToChatReq.serializer,
        json,
      );
}
