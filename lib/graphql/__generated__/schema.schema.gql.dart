// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'schema.schema.gql.g.dart';

class GPlatform extends EnumClass {
  const GPlatform._(String name) : super(name);

  static const GPlatform MOBILE = _$gPlatformMOBILE;

  static const GPlatform WEB = _$gPlatformWEB;

  static Serializer<GPlatform> get serializer => _$gPlatformSerializer;

  static BuiltSet<GPlatform> get values => _$gPlatformValues;

  static GPlatform valueOf(String name) => _$gPlatformValueOf(name);
}

class GCallSignalType extends EnumClass {
  const GCallSignalType._(String name) : super(name);

  static const GCallSignalType OFFER = _$gCallSignalTypeOFFER;

  static const GCallSignalType ANSWER = _$gCallSignalTypeANSWER;

  static const GCallSignalType ICE_CANDIDATE = _$gCallSignalTypeICE_CANDIDATE;

  static const GCallSignalType HANGUP = _$gCallSignalTypeHANGUP;

  static Serializer<GCallSignalType> get serializer =>
      _$gCallSignalTypeSerializer;

  static BuiltSet<GCallSignalType> get values => _$gCallSignalTypeValues;

  static GCallSignalType valueOf(String name) => _$gCallSignalTypeValueOf(name);
}

const Map<String, Set<String>> possibleTypesMap = {};
