import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schleusung.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false)
class Schleusung {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: '_rev')
  String? rev;
  String? pferdId;
  String? tuer;
  String? rfid;
  String? time;
  String? standname;
  String? richtung;

  Schleusung(
      {this.id,
      this.rev,
      this.pferdId,
      this.tuer,
      this.rfid,
      this.time,
      this.standname,
      this.richtung});
  factory Schleusung.fromJson(Map<String, dynamic> json) =>
      _$SchleusungFromJson(json);
  Map<String, dynamic> toJson() => _$SchleusungToJson(this);

  compareTo(Schleusung b) {
    if (time != null && b.time != null) {
      return time!.compareTo(b.time!);
    }
    return 0;
  }
}
