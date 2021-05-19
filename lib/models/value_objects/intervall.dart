import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intervall.g.dart';

@CopyWith()
@JsonSerializable()
class SchleusenInterval {
  String standname;
  String tuername;
  String von;
  String bis;
  SchleusenInterval(
      {required this.bis,
      required this.standname,
      required this.tuername,
      required this.von});

  factory SchleusenInterval.fromJson(Map<String, dynamic> json) =>
      _$SchleusenIntervalFromJson(json);
  Map<String, dynamic> toJson() => _$SchleusenIntervalToJson(this);
}

@CopyWith()
@JsonSerializable()
class FutterschieberInterval {
  String standname;
  String schiebername;
  int openTimeWithoutRfidReading;
  String von;
  String bis;
  FutterschieberInterval(
      {required this.bis,
      required this.openTimeWithoutRfidReading,
      required this.schiebername,
      required this.standname,
      required this.von});
  factory FutterschieberInterval.fromJson(Map<String, dynamic> json) =>
      _$FutterschieberIntervalFromJson(json);
  Map<String, dynamic> toJson() => _$FutterschieberIntervalToJson(this);
}
