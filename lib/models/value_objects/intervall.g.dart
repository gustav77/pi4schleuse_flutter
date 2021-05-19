// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervall.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension SchleusenIntervalCopyWith on SchleusenInterval {
  SchleusenInterval copyWith({
    String? bis,
    String? standname,
    String? tuername,
    String? von,
  }) {
    return SchleusenInterval(
      bis: bis ?? this.bis,
      standname: standname ?? this.standname,
      tuername: tuername ?? this.tuername,
      von: von ?? this.von,
    );
  }
}

extension FutterschieberIntervalCopyWith on FutterschieberInterval {
  FutterschieberInterval copyWith({
    String? bis,
    int? openTimeWithoutRfidReading,
    String? schiebername,
    String? standname,
    String? von,
  }) {
    return FutterschieberInterval(
      bis: bis ?? this.bis,
      openTimeWithoutRfidReading:
          openTimeWithoutRfidReading ?? this.openTimeWithoutRfidReading,
      schiebername: schiebername ?? this.schiebername,
      standname: standname ?? this.standname,
      von: von ?? this.von,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchleusenInterval _$SchleusenIntervalFromJson(Map<String, dynamic> json) {
  return SchleusenInterval(
    bis: json['bis'] as String,
    standname: json['standname'] as String,
    tuername: json['tuername'] as String,
    von: json['von'] as String,
  );
}

Map<String, dynamic> _$SchleusenIntervalToJson(SchleusenInterval instance) =>
    <String, dynamic>{
      'standname': instance.standname,
      'tuername': instance.tuername,
      'von': instance.von,
      'bis': instance.bis,
    };

FutterschieberInterval _$FutterschieberIntervalFromJson(
    Map<String, dynamic> json) {
  return FutterschieberInterval(
    bis: json['bis'] as String,
    openTimeWithoutRfidReading: json['openTimeWithoutRfidReading'] as int,
    schiebername: json['schiebername'] as String,
    standname: json['standname'] as String,
    von: json['von'] as String,
  );
}

Map<String, dynamic> _$FutterschieberIntervalToJson(
        FutterschieberInterval instance) =>
    <String, dynamic>{
      'standname': instance.standname,
      'schiebername': instance.schiebername,
      'openTimeWithoutRfidReading': instance.openTimeWithoutRfidReading,
      'von': instance.von,
      'bis': instance.bis,
    };
