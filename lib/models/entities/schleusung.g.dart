// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schleusung.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension SchleusungCopyWith on Schleusung {
  Schleusung copyWith({
    String? id,
    String? pferdId,
    String? rev,
    String? rfid,
    String? richtung,
    String? standname,
    String? time,
    String? tuer,
  }) {
    return Schleusung(
      id: id ?? this.id,
      pferdId: pferdId ?? this.pferdId,
      rev: rev ?? this.rev,
      rfid: rfid ?? this.rfid,
      richtung: richtung ?? this.richtung,
      standname: standname ?? this.standname,
      time: time ?? this.time,
      tuer: tuer ?? this.tuer,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schleusung _$SchleusungFromJson(Map<String, dynamic> json) {
  return Schleusung(
    id: json['_id'] as String?,
    rev: json['_rev'] as String?,
    pferdId: json['pferdId'] as String?,
    tuer: json['tuer'] as String?,
    rfid: json['rfid'] as String?,
    time: json['time'] as String?,
    standname: json['standname'] as String?,
    richtung: json['richtung'] as String?,
  );
}

Map<String, dynamic> _$SchleusungToJson(Schleusung instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  writeNotNull('_rev', instance.rev);
  writeNotNull('pferdId', instance.pferdId);
  writeNotNull('tuer', instance.tuer);
  writeNotNull('rfid', instance.rfid);
  writeNotNull('time', instance.time);
  writeNotNull('standname', instance.standname);
  writeNotNull('richtung', instance.richtung);
  return val;
}
