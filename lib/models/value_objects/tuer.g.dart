// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tuer.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension TuerCopyWith on Tuer {
  Tuer copyWith({
    String? name,
    int? openTime,
    String? standname,
    int? timeToClose,
  }) {
    return Tuer(
      name: name ?? this.name,
      openTime: openTime ?? this.openTime,
      standname: standname ?? this.standname,
      timeToClose: timeToClose ?? this.timeToClose,
    );
  }
}

extension NachlaufsperreCopyWith on Nachlaufsperre {
  Nachlaufsperre copyWith({
    int? timeToClose,
  }) {
    return Nachlaufsperre(
      timeToClose: timeToClose ?? this.timeToClose,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tuer _$TuerFromJson(Map<String, dynamic> json) {
  return Tuer(
    name: json['name'] as String,
    openTime: json['openTime'] as int? ?? 0,
    timeToClose: json['timeToClose'] as int,
    standname: json['standname'] as String?,
  );
}

Map<String, dynamic> _$TuerToJson(Tuer instance) => <String, dynamic>{
      'name': instance.name,
      'timeToClose': instance.timeToClose,
      'openTime': instance.openTime,
      'standname': instance.standname,
    };

Nachlaufsperre _$NachlaufsperreFromJson(Map<String, dynamic> json) {
  return Nachlaufsperre(
    timeToClose: json['timeToClose'] as int,
  );
}

Map<String, dynamic> _$NachlaufsperreToJson(Nachlaufsperre instance) =>
    <String, dynamic>{
      'timeToClose': instance.timeToClose,
    };
