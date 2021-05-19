import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:piflutter/models/value_objects/dosierung.dart';
import 'package:piflutter/models/value_objects/intervall.dart';

import 'package:piflutter/models/value_objects/ration.dart';
import 'package:piflutter/models/entities/rfidstand.dart';

part 'pferd.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false)
class Pferd {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: '_rev')
  String? rev;
  @JsonKey(defaultValue: '')
  String name;
  @JsonKey(defaultValue: '')
  String? rfid;
  @JsonKey(defaultValue: '')
  String? rfid_2;
  @JsonKey(defaultValue: '')
  String? besitzer;
  List<Dosierung>? rationen;
  List<SchleusenInterval>? intervalle;
  List<FutterschieberInterval>? futterschieber;
  List<Ration>? letzteRationen;
  List<SummenRation>? summenRationen;

  Pferd(
      {required this.name,
      this.besitzer,
      this.futterschieber,
      this.intervalle,
      this.letzteRationen,
      this.rationen,
      this.rfid,
      this.rfid_2,
      this.summenRationen,
      this.id,
      this.rev});

  factory Pferd.fromJson(Map<String, dynamic> json) => _$PferdFromJson(json);
  Map<String, dynamic> toJson() => _$PferdToJson(this);
}

@JsonSerializable()
@CopyWith()
class PferdRaw {
  // ignore: non_constant_identifier_names
  int total_rows;
  int offset;
  List<ValueWrapper> rows;

  PferdRaw(
      {required this.total_rows, required this.offset, required this.rows});

  factory PferdRaw.fromJson(Map<String, dynamic> json) =>
      _$PferdRawFromJson(json);
  Map<String, dynamic> toJson() => _$PferdRawToJson(this);
}
