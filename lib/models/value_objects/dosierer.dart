import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dosierer.g.dart';

@JsonSerializable()
@CopyWith()
class Dosierer {
  String? standname;
  String name;
  String futtername;
  int grammPerTenSeconds;
  Dosierer(
      {required this.futtername,
      required this.name,
      required this.grammPerTenSeconds,
      this.standname});
  factory Dosierer.fromJson(Map<String, dynamic> json) =>
      _$DosiererFromJson(json);
  Map<String, dynamic> toJson() => _$DosiererToJson(this);
}
