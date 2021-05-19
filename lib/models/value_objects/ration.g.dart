// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension RationCopyWith on Ration {
  Ration copyWith({
    String? futtername,
    int? menge,
    String? time,
  }) {
    return Ration(
      futtername: futtername ?? this.futtername,
      menge: menge ?? this.menge,
      time: time ?? this.time,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ration _$RationFromJson(Map<String, dynamic> json) {
  return Ration(
    futtername: json['futtername'] as String,
    menge: json['menge'] as int,
    time: json['time'] as String,
  );
}

Map<String, dynamic> _$RationToJson(Ration instance) => <String, dynamic>{
      'futtername': instance.futtername,
      'menge': instance.menge,
      'time': instance.time,
    };

SummenRation _$SummenRationFromJson(Map<String, dynamic> json) {
  return SummenRation(
    futtername: json['futtername'] as String,
    menge24h: json['menge24h'] as int,
    mengeMonat: json['mengeMonat'] as int,
  );
}

Map<String, dynamic> _$SummenRationToJson(SummenRation instance) =>
    <String, dynamic>{
      'futtername': instance.futtername,
      'menge24h': instance.menge24h,
      'mengeMonat': instance.mengeMonat,
    };
