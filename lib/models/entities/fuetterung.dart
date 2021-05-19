import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fuetterung.g.dart';

@CopyWith()
@JsonSerializable(includeIfNull: false)
class Fuetterung {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: '_rev')
  String? rev;
  String? pferdId;
  String? dosierer;
  String? rfid;
  int? menge;
  String? time;
  String? standname;
  String? futtername;

  Fuetterung(
      {this.id,
      this.rev,
      this.pferdId,
      this.dosierer,
      this.rfid,
      this.menge,
      this.time,
      this.standname,
      this.futtername});
  factory Fuetterung.fromJson(Map<String, dynamic> json) =>
      _$FuetterungFromJson(json);
  Map<String, dynamic> toJson() => _$FuetterungToJson(this);

  compareTo(Fuetterung b) {
    if (time != null && b.time != null) {
      return time!.compareTo(b.time!);
    }
    return 0;
  }
}
