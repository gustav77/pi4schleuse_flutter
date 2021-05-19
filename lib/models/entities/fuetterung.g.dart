// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuetterung.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension FuetterungCopyWith on Fuetterung {
  Fuetterung copyWith({
    String? dosierer,
    String? futtername,
    String? id,
    int? menge,
    String? pferdId,
    String? rev,
    String? rfid,
    String? standname,
    String? time,
  }) {
    return Fuetterung(
      dosierer: dosierer ?? this.dosierer,
      futtername: futtername ?? this.futtername,
      id: id ?? this.id,
      menge: menge ?? this.menge,
      pferdId: pferdId ?? this.pferdId,
      rev: rev ?? this.rev,
      rfid: rfid ?? this.rfid,
      standname: standname ?? this.standname,
      time: time ?? this.time,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fuetterung _$FuetterungFromJson(Map<String, dynamic> json) {
  return Fuetterung(
    id: json['_id'] as String?,
    rev: json['_rev'] as String?,
    pferdId: json['pferdId'] as String?,
    dosierer: json['dosierer'] as String?,
    rfid: json['rfid'] as String?,
    menge: json['menge'] as int?,
    time: json['time'] as String?,
    standname: json['standname'] as String?,
    futtername: json['futtername'] as String?,
  );
}

Map<String, dynamic> _$FuetterungToJson(Fuetterung instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  writeNotNull('_rev', instance.rev);
  writeNotNull('pferdId', instance.pferdId);
  writeNotNull('dosierer', instance.dosierer);
  writeNotNull('rfid', instance.rfid);
  writeNotNull('menge', instance.menge);
  writeNotNull('time', instance.time);
  writeNotNull('standname', instance.standname);
  writeNotNull('futtername', instance.futtername);
  return val;
}
