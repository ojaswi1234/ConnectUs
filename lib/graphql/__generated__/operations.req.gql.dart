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

abstract class GPostMessageReq
    implements
        Built<GPostMessageReq, GPostMessageReqBuilder>,
        _i1.OperationRequest<_i2.GPostMessageData, _i3.GPostMessageVars> {
  GPostMessageReq._();

  factory GPostMessageReq([void Function(GPostMessageReqBuilder b) updates]) =
      _$GPostMessageReq;

  static void _initializeBuilder(GPostMessageReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'PostMessage',
    )
    ..executeOnListen = true;

  @override
  _i3.GPostMessageVars get vars;
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
  _i2.GPostMessageData? Function(
    _i2.GPostMessageData?,
    _i2.GPostMessageData?,
  )? get updateResult;
  @override
  _i2.GPostMessageData? get optimisticResponse;
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
  _i2.GPostMessageData? parseData(Map<String, dynamic> json) =>
      _i2.GPostMessageData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GPostMessageData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GPostMessageData, _i3.GPostMessageVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GPostMessageReq> get serializer =>
      _$gPostMessageReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GPostMessageReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPostMessageReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GPostMessageReq.serializer,
        json,
      );
}
