import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ration.g.dart';

@JsonSerializable()
@CopyWith()
class Ration {
  String futtername;
  int menge;
  String time;
  Ration({required this.futtername, required this.menge, required this.time});
  factory Ration.fromJson(Map<String, dynamic> json) => _$RationFromJson(json);
  Map<String, dynamic> toJson() => _$RationToJson(this);
}

@JsonSerializable()
class SummenRation {
  String futtername;
  int menge24h;
  int mengeMonat;
  SummenRation(
      {required this.futtername,
      required this.menge24h,
      required this.mengeMonat});

  factory SummenRation.fromJson(Map<String, dynamic> json) =>
      _$SummenRationFromJson(json);
  Map<String, dynamic> toJson() => _$SummenRationToJson(this);
}
