import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dosierung.g.dart';

@CopyWith()
@JsonSerializable()
class Dosierung {
  String futtername;
  int portion;
  int tageslimit;
  int pause;
  int? fresszeit;
  int? teilpause;
  int? teilportion;
  @JsonKey(defaultValue: false)
  bool intervalldosierung;
  Dosierung(
      {this.fresszeit,
      required this.futtername,
      required this.pause,
      required this.portion,
      required this.tageslimit,
      this.teilpause,
      this.teilportion,
      required this.intervalldosierung});

  factory Dosierung.fromJson(Map<String, dynamic> json) =>
      _$DosierungFromJson(json);
  Map<String, dynamic> toJson() => _$DosierungToJson(this);
}
