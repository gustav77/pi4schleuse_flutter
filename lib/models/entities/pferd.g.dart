// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pferd.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PferdCopyWith on Pferd {
  Pferd copyWith({
    String? besitzer,
    List<FutterschieberInterval>? futterschieber,
    String? id,
    List<SchleusenInterval>? intervalle,
    List<Ration>? letzteRationen,
    String? name,
    List<Dosierung>? rationen,
    String? rev,
    String? rfid,
    String? rfid_2,
    List<SummenRation>? summenRationen,
  }) {
    return Pferd(
      besitzer: besitzer ?? this.besitzer,
      futterschieber: futterschieber ?? this.futterschieber,
      id: id ?? this.id,
      intervalle: intervalle ?? this.intervalle,
      letzteRationen: letzteRationen ?? this.letzteRationen,
      name: name ?? this.name,
      rationen: rationen ?? this.rationen,
      rev: rev ?? this.rev,
      rfid: rfid ?? this.rfid,
      rfid_2: rfid_2 ?? this.rfid_2,
      summenRationen: summenRationen ?? this.summenRationen,
    );
  }
}

extension PferdRawCopyWith on PferdRaw {
  PferdRaw copyWith({
    int? offset,
    List<ValueWrapper>? rows,
    int? total_rows,
  }) {
    return PferdRaw(
      offset: offset ?? this.offset,
      rows: rows ?? this.rows,
      total_rows: total_rows ?? this.total_rows,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pferd _$PferdFromJson(Map<String, dynamic> json) {
  return Pferd(
    name: json['name'] as String? ?? '',
    besitzer: json['besitzer'] as String? ?? '',
    futterschieber: (json['futterschieber'] as List<dynamic>?)
        ?.map((e) => FutterschieberInterval.fromJson(e as Map<String, dynamic>))
        .toList(),
    intervalle: (json['intervalle'] as List<dynamic>?)
        ?.map((e) => SchleusenInterval.fromJson(e as Map<String, dynamic>))
        .toList(),
    letzteRationen: (json['letzteRationen'] as List<dynamic>?)
        ?.map((e) => Ration.fromJson(e as Map<String, dynamic>))
        .toList(),
    rationen: (json['rationen'] as List<dynamic>?)
        ?.map((e) => Dosierung.fromJson(e as Map<String, dynamic>))
        .toList(),
    rfid: json['rfid'] as String? ?? '',
    rfid_2: json['rfid_2'] as String? ?? '',
    summenRationen: (json['summenRationen'] as List<dynamic>?)
        ?.map((e) => SummenRation.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['_id'] as String?,
    rev: json['_rev'] as String?,
  );
}

Map<String, dynamic> _$PferdToJson(Pferd instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  writeNotNull('_rev', instance.rev);
  val['name'] = instance.name;
  writeNotNull('rfid', instance.rfid);
  writeNotNull('rfid_2', instance.rfid_2);
  writeNotNull('besitzer', instance.besitzer);
  writeNotNull('rationen', instance.rationen);
  writeNotNull('intervalle', instance.intervalle);
  writeNotNull('futterschieber', instance.futterschieber);
  writeNotNull('letzteRationen', instance.letzteRationen);
  writeNotNull('summenRationen', instance.summenRationen);
  return val;
}

PferdRaw _$PferdRawFromJson(Map<String, dynamic> json) {
  return PferdRaw(
    total_rows: json['total_rows'] as int,
    offset: json['offset'] as int,
    rows: (json['rows'] as List<dynamic>)
        .map((e) => ValueWrapper.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PferdRawToJson(PferdRaw instance) => <String, dynamic>{
      'total_rows': instance.total_rows,
      'offset': instance.offset,
      'rows': instance.rows,
    };
