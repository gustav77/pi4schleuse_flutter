import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:piflutter/models/value_objects/dosierer.dart';
import 'package:piflutter/models/value_objects/intervall.dart';
import 'package:piflutter/models/value_objects/tuer.dart';

part 'rfidstand.g.dart';

@JsonSerializable(includeIfNull: false)
@CopyWith()
class Rfidstand {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: '_rev')
  String rev;
  String name;
  String ip;
  List<Dosierer>? dosierer;
  List<Tuer>? tueren;
  List<Futterschieber>? futterschieber;
  Nachlaufsperre? nachlaufsperre;
  bool? lichttaster;
  bool? fullduplex;
  List<SchleusenInterval>? zeitschaltungen;
  String? operationmode;
  Rfidstand(
      {required this.ip,
      required this.id,
      required this.rev,
      required this.name,
      this.dosierer,
      this.lichttaster,
      this.fullduplex,
      this.nachlaufsperre,
      this.operationmode,
      this.tueren,
      this.zeitschaltungen});

  factory Rfidstand.fromJson(Map<String, dynamic> json) =>
      _$RfidstandFromJson(json);
  Map<String, dynamic> toJson() => _$RfidstandToJson(this);
}

@JsonSerializable()
@CopyWith()
class RfidstandRaw {
  // ignore: non_constant_identifier_names
  int total_rows;
  int offset;
  List<ValueWrapper> rows;

  RfidstandRaw(
      {required this.total_rows, required this.offset, required this.rows});

  factory RfidstandRaw.fromJson(Map<String, dynamic> json) =>
      _$RfidstandRawFromJson(json);
  Map<String, dynamic> toJson() => _$RfidstandRawToJson(this);
}

@JsonSerializable()
@CopyWith()
class ValueWrapper {
  String id;
  String key;
  Rfidstand value;
  ValueWrapper({required this.id, required this.key, required this.value});
  factory ValueWrapper.fromJson(Map<String, dynamic> json) =>
      _$ValueWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$ValueWrapperToJson(this);
}

@JsonSerializable()
@CopyWith()
class RfidstandKonfiguration {
  @JsonKey(name: 'hat_futterschieber')
  bool hatFutterschieber;
  @JsonKey(name: 'hat_lichttaster')
  bool hatLichttaster;
  @JsonKey(name: 'hat_lichttaster_rein')
  bool hatLichttasterRein;
  @JsonKey(name: 'hat_lichttaster_raus')
  bool hatLichttasterRaus;
  @JsonKey(name: 'fullduplex_schleuse')
  bool fullduplexSchleuse;
  @JsonKey(name: 'faread_reader')
  bool fareadReader;
  @JsonKey(name: 'hat_nachlaufsperre')
  bool hatNachlaufsperre;
  @JsonKey(name: 'hat_tuer1')
  bool hatTuer1;
  @JsonKey(name: 'hat_tuer2')
  bool hatTuer2;
  @JsonKey(name: 'hat_dosierer1')
  bool hatDosierer1;
  @JsonKey(name: 'hat_dosierer2')
  bool hatDosierer2;
  RfidstandKonfiguration(
      {required this.fareadReader,
      required this.fullduplexSchleuse,
      required this.hatDosierer1,
      required this.hatDosierer2,
      required this.hatFutterschieber,
      required this.hatLichttaster,
      required this.hatLichttasterRaus,
      required this.hatLichttasterRein,
      required this.hatNachlaufsperre,
      required this.hatTuer1,
      required this.hatTuer2});
  factory RfidstandKonfiguration.fromJson(Map<String, dynamic> json) =>
      _$RfidstandKonfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$RfidstandKonfigurationToJson(this);
}

@JsonSerializable()
@CopyWith()
class Futterschieber {
  int timeToClose;
  String? schiebername;
  String? standname;
  String name;
  Futterschieber({required this.name, required this.timeToClose});
  Futterschieber.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        timeToClose = json['timeToClose'],
        schiebername = json['schiebername'],
        standname = json['standname'];
}
