// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rfidstand.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension RfidstandCopyWith on Rfidstand {
  Rfidstand copyWith({
    List<Dosierer>? dosierer,
    String? id,
    String? ip,
    bool? lichttaster,
    Nachlaufsperre? nachlaufsperre,
    String? name,
    String? operationmode,
    String? rev,
    List<Tuer>? tueren,
    List<SchleusenInterval>? zeitschaltungen,
  }) {
    return Rfidstand(
      dosierer: dosierer ?? this.dosierer,
      id: id ?? this.id,
      ip: ip ?? this.ip,
      lichttaster: lichttaster ?? this.lichttaster,
      nachlaufsperre: nachlaufsperre ?? this.nachlaufsperre,
      name: name ?? this.name,
      operationmode: operationmode ?? this.operationmode,
      rev: rev ?? this.rev,
      tueren: tueren ?? this.tueren,
      zeitschaltungen: zeitschaltungen ?? this.zeitschaltungen,
    );
  }
}

extension RfidstandRawCopyWith on RfidstandRaw {
  RfidstandRaw copyWith({
    int? offset,
    List<ValueWrapper>? rows,
    int? total_rows,
  }) {
    return RfidstandRaw(
      offset: offset ?? this.offset,
      rows: rows ?? this.rows,
      total_rows: total_rows ?? this.total_rows,
    );
  }
}

extension ValueWrapperCopyWith on ValueWrapper {
  ValueWrapper copyWith({
    String? id,
    String? key,
    Rfidstand? value,
  }) {
    return ValueWrapper(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }
}

extension RfidstandKonfigurationCopyWith on RfidstandKonfiguration {
  RfidstandKonfiguration copyWith({
    bool? fareadReader,
    bool? fullduplexSchleuse,
    bool? hatDosierer1,
    bool? hatDosierer2,
    bool? hatFutterschieber,
    bool? hatLichttaster,
    bool? hatLichttasterRaus,
    bool? hatLichttasterRein,
    bool? hatNachlaufsperre,
    bool? hatTuer1,
    bool? hatTuer2,
  }) {
    return RfidstandKonfiguration(
      fareadReader: fareadReader ?? this.fareadReader,
      fullduplexSchleuse: fullduplexSchleuse ?? this.fullduplexSchleuse,
      hatDosierer1: hatDosierer1 ?? this.hatDosierer1,
      hatDosierer2: hatDosierer2 ?? this.hatDosierer2,
      hatFutterschieber: hatFutterschieber ?? this.hatFutterschieber,
      hatLichttaster: hatLichttaster ?? this.hatLichttaster,
      hatLichttasterRaus: hatLichttasterRaus ?? this.hatLichttasterRaus,
      hatLichttasterRein: hatLichttasterRein ?? this.hatLichttasterRein,
      hatNachlaufsperre: hatNachlaufsperre ?? this.hatNachlaufsperre,
      hatTuer1: hatTuer1 ?? this.hatTuer1,
      hatTuer2: hatTuer2 ?? this.hatTuer2,
    );
  }
}

extension FutterschieberCopyWith on Futterschieber {
  Futterschieber copyWith({
    String? name,
    int? timeToClose,
  }) {
    return Futterschieber(
      name: name ?? this.name,
      timeToClose: timeToClose ?? this.timeToClose,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rfidstand _$RfidstandFromJson(Map<String, dynamic> json) {
  return Rfidstand(
    ip: json['ip'] as String,
    id: json['_id'] as String,
    rev: json['_rev'] as String,
    name: json['name'] as String,
    dosierer: (json['dosierer'] as List<dynamic>?)
        ?.map((e) => Dosierer.fromJson(e as Map<String, dynamic>))
        .toList(),
    lichttaster: json['lichttaster'] as bool?,
    nachlaufsperre: json['nachlaufsperre'] == null
        ? null
        : Nachlaufsperre.fromJson(
            json['nachlaufsperre'] as Map<String, dynamic>),
    operationmode: json['operationmode'] as String?,
    tueren: (json['tueren'] as List<dynamic>?)
        ?.map((e) => Tuer.fromJson(e as Map<String, dynamic>))
        .toList(),
    zeitschaltungen: (json['zeitschaltungen'] as List<dynamic>?)
        ?.map((e) => SchleusenInterval.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..futterschieber = (json['futterschieber'] as List<dynamic>?)
      ?.map((e) => Futterschieber.fromJson(e as Map<String, dynamic>))
      .toList();
}

Map<String, dynamic> _$RfidstandToJson(Rfidstand instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    '_rev': instance.rev,
    'name': instance.name,
    'ip': instance.ip,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dosierer', instance.dosierer);
  writeNotNull('tueren', instance.tueren);
  writeNotNull('futterschieber', instance.futterschieber);
  writeNotNull('nachlaufsperre', instance.nachlaufsperre);
  writeNotNull('lichttaster', instance.lichttaster);
  writeNotNull('zeitschaltungen', instance.zeitschaltungen);
  writeNotNull('operationmode', instance.operationmode);
  return val;
}

RfidstandRaw _$RfidstandRawFromJson(Map<String, dynamic> json) {
  return RfidstandRaw(
    total_rows: json['total_rows'] as int,
    offset: json['offset'] as int,
    rows: (json['rows'] as List<dynamic>)
        .map((e) => ValueWrapper.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RfidstandRawToJson(RfidstandRaw instance) =>
    <String, dynamic>{
      'total_rows': instance.total_rows,
      'offset': instance.offset,
      'rows': instance.rows,
    };

ValueWrapper _$ValueWrapperFromJson(Map<String, dynamic> json) {
  return ValueWrapper(
    id: json['id'] as String,
    key: json['key'] as String,
    value: Rfidstand.fromJson(json['value'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ValueWrapperToJson(ValueWrapper instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'value': instance.value,
    };

RfidstandKonfiguration _$RfidstandKonfigurationFromJson(
    Map<String, dynamic> json) {
  return RfidstandKonfiguration(
    fareadReader: json['faread_reader'] as bool,
    fullduplexSchleuse: json['fullduplex_schleuse'] as bool,
    hatDosierer1: json['hat_dosierer1'] as bool,
    hatDosierer2: json['hat_dosierer2'] as bool,
    hatFutterschieber: json['hat_futterschieber'] as bool,
    hatLichttaster: json['hat_lichttaster'] as bool,
    hatLichttasterRaus: json['hat_lichttaster_raus'] as bool,
    hatLichttasterRein: json['hat_lichttaster_rein'] as bool,
    hatNachlaufsperre: json['hat_nachlaufsperre'] as bool,
    hatTuer1: json['hat_tuer1'] as bool,
    hatTuer2: json['hat_tuer2'] as bool,
  );
}

Map<String, dynamic> _$RfidstandKonfigurationToJson(
        RfidstandKonfiguration instance) =>
    <String, dynamic>{
      'hat_futterschieber': instance.hatFutterschieber,
      'hat_lichttaster': instance.hatLichttaster,
      'hat_lichttaster_rein': instance.hatLichttasterRein,
      'hat_lichttaster_raus': instance.hatLichttasterRaus,
      'fullduplex_schleuse': instance.fullduplexSchleuse,
      'faread_reader': instance.fareadReader,
      'hat_nachlaufsperre': instance.hatNachlaufsperre,
      'hat_tuer1': instance.hatTuer1,
      'hat_tuer2': instance.hatTuer2,
      'hat_dosierer1': instance.hatDosierer1,
      'hat_dosierer2': instance.hatDosierer2,
    };

Futterschieber _$FutterschieberFromJson(Map<String, dynamic> json) {
  return Futterschieber(
    name: json['name'] as String,
    timeToClose: json['timeToClose'] as int,
  )
    ..schiebername = json['schiebername'] as String?
    ..standname = json['standname'] as String?;
}

Map<String, dynamic> _$FutterschieberToJson(Futterschieber instance) =>
    <String, dynamic>{
      'timeToClose': instance.timeToClose,
      'schiebername': instance.schiebername,
      'standname': instance.standname,
      'name': instance.name,
    };
