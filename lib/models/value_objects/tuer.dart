import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tuer.g.dart';

@JsonSerializable()
@CopyWith()
class Tuer {
  String name;
  int timeToClose;
  @JsonKey(defaultValue: 0)
  int openTime;
  String? standname;
  Tuer(
      {required this.name,
      required this.openTime,
      required this.timeToClose,
      this.standname});

  factory Tuer.fromJson(Map<String, dynamic> json) => _$TuerFromJson(json);
  Map<String, dynamic> toJson() => _$TuerToJson(this);
}

@JsonSerializable()
@CopyWith()
class Nachlaufsperre {
  int timeToClose;
  Nachlaufsperre({required this.timeToClose});

  factory Nachlaufsperre.fromJson(Map<String, dynamic> json) =>
      _$NachlaufsperreFromJson(json);
  Map<String, dynamic> toJson() => _$NachlaufsperreToJson(this);
}
