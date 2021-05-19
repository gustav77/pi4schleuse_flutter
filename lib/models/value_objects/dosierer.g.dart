// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dosierer.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension DosiererCopyWith on Dosierer {
  Dosierer copyWith({
    String? futtername,
    int? grammPerTenSeconds,
    String? name,
    String? standname,
  }) {
    return Dosierer(
      futtername: futtername ?? this.futtername,
      grammPerTenSeconds: grammPerTenSeconds ?? this.grammPerTenSeconds,
      name: name ?? this.name,
      standname: standname ?? this.standname,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dosierer _$DosiererFromJson(Map<String, dynamic> json) {
  return Dosierer(
    futtername: json['futtername'] as String,
    name: json['name'] as String,
    grammPerTenSeconds: json['grammPerTenSeconds'] as int,
    standname: json['standname'] as String?,
  );
}

Map<String, dynamic> _$DosiererToJson(Dosierer instance) => <String, dynamic>{
      'standname': instance.standname,
      'name': instance.name,
      'futtername': instance.futtername,
      'grammPerTenSeconds': instance.grammPerTenSeconds,
    };
