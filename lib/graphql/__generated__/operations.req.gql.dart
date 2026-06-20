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

abstract class GGetMessagesReq
    implements
        Built<GGetMessagesReq, GGetMessagesReqBuilder>,
        _i1.OperationRequest<_i2.GGetMessagesData, _i3.GGetMessagesVars> {
  GGetMessagesReq._();

  factory GGetMessagesReq([void Function(GGetMessagesReqBuilder b) updates]) =
      _$GGetMessagesReq;

  static void _initializeBuilder(GGetMessagesReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetMessages',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetMessagesVars get vars;
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
  _i2.GGetMessagesData? Function(
    _i2.GGetMessagesData?,
    _i2.GGetMessagesData?,
  )? get updateResult;
  @override
  _i2.GGetMessagesData? get optimisticResponse;
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
  _i2.GGetMessagesData? parseData(Map<String, dynamic> json) =>
      _i2.GGetMessagesData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetMessagesData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetMessagesData, _i3.GGetMessagesVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetMessagesReq> get serializer =>
      _$gGetMessagesReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetMessagesReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetMessagesReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetMessagesReq.serializer,
        json,
      );
}

abstract class GSendMessageReq
    implements
        Built<GSendMessageReq, GSendMessageReqBuilder>,
        _i1.OperationRequest<_i2.GSendMessageData, _i3.GSendMessageVars> {
  GSendMessageReq._();

  factory GSendMessageReq([void Function(GSendMessageReqBuilder b) updates]) =
      _$GSendMessageReq;

  static void _initializeBuilder(GSendMessageReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'SendMessage',
    )
    ..executeOnListen = true;

  @override
  _i3.GSendMessageVars get vars;
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
  _i2.GSendMessageData? Function(
    _i2.GSendMessageData?,
    _i2.GSendMessageData?,
  )? get updateResult;
  @override
  _i2.GSendMessageData? get optimisticResponse;
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
  _i2.GSendMessageData? parseData(Map<String, dynamic> json) =>
      _i2.GSendMessageData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSendMessageData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GSendMessageData, _i3.GSendMessageVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GSendMessageReq> get serializer =>
      _$gSendMessageReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GSendMessageReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendMessageReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GSendMessageReq.serializer,
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
