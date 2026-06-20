// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GPlatform _$gPlatformMOBILE = const GPlatform._('MOBILE');
const GPlatform _$gPlatformWEB = const GPlatform._('WEB');

GPlatform _$gPlatformValueOf(String name) {
  switch (name) {
    case 'MOBILE':
      return _$gPlatformMOBILE;
    case 'WEB':
      return _$gPlatformWEB;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GPlatform> _$gPlatformValues =
    new BuiltSet<GPlatform>(const <GPlatform>[
  _$gPlatformMOBILE,
  _$gPlatformWEB,
]);

const GCallSignalType _$gCallSignalTypeOFFER = const GCallSignalType._('OFFER');
const GCallSignalType _$gCallSignalTypeANSWER =
    const GCallSignalType._('ANSWER');
const GCallSignalType _$gCallSignalTypeICE_CANDIDATE =
    const GCallSignalType._('ICE_CANDIDATE');
const GCallSignalType _$gCallSignalTypeHANGUP =
    const GCallSignalType._('HANGUP');

GCallSignalType _$gCallSignalTypeValueOf(String name) {
  switch (name) {
    case 'OFFER':
      return _$gCallSignalTypeOFFER;
    case 'ANSWER':
      return _$gCallSignalTypeANSWER;
    case 'ICE_CANDIDATE':
      return _$gCallSignalTypeICE_CANDIDATE;
    case 'HANGUP':
      return _$gCallSignalTypeHANGUP;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GCallSignalType> _$gCallSignalTypeValues =
    new BuiltSet<GCallSignalType>(const <GCallSignalType>[
  _$gCallSignalTypeOFFER,
  _$gCallSignalTypeANSWER,
  _$gCallSignalTypeICE_CANDIDATE,
  _$gCallSignalTypeHANGUP,
]);

Serializer<GPlatform> _$gPlatformSerializer = new _$GPlatformSerializer();
Serializer<GCallSignalType> _$gCallSignalTypeSerializer =
    new _$GCallSignalTypeSerializer();

class _$GPlatformSerializer implements PrimitiveSerializer<GPlatform> {
  @override
  final Iterable<Type> types = const <Type>[GPlatform];
  @override
  final String wireName = 'GPlatform';

  @override
  Object serialize(Serializers serializers, GPlatform object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GPlatform deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GPlatform.valueOf(serialized as String);
}

class _$GCallSignalTypeSerializer
    implements PrimitiveSerializer<GCallSignalType> {
  @override
  final Iterable<Type> types = const <Type>[GCallSignalType];
  @override
  final String wireName = 'GCallSignalType';

  @override
  Object serialize(Serializers serializers, GCallSignalType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GCallSignalType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GCallSignalType.valueOf(serialized as String);
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
