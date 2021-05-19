import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rfid.g.dart';

@CopyWith()
@JsonSerializable()
class Rfid {
  String rfid;
  Rfid({required this.rfid});
  factory Rfid.fromJson(Map<String, dynamic> json) => _$RfidFromJson(json);
  Map<String, dynamic> toJson() => _$RfidToJson(this);
}
