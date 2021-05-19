// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dosierung.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension DosierungCopyWith on Dosierung {
  Dosierung copyWith({
    int? fresszeit,
    String? futtername,
    bool? intervalldosierung,
    int? pause,
    int? portion,
    int? tageslimit,
    int? teilpause,
    int? teilportion,
  }) {
    return Dosierung(
      fresszeit: fresszeit ?? this.fresszeit,
      futtername: futtername ?? this.futtername,
      intervalldosierung: intervalldosierung ?? this.intervalldosierung,
      pause: pause ?? this.pause,
      portion: portion ?? this.portion,
      tageslimit: tageslimit ?? this.tageslimit,
      teilpause: teilpause ?? this.teilpause,
      teilportion: teilportion ?? this.teilportion,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dosierung _$DosierungFromJson(Map<String, dynamic> json) {
  return Dosierung(
    fresszeit: json['fresszeit'] as int?,
    futtername: json['futtername'] as String,
    pause: json['pause'] as int,
    portion: json['portion'] as int,
    tageslimit: json['tageslimit'] as int,
    teilpause: json['teilpause'] as int?,
    teilportion: json['teilportion'] as int?,
    intervalldosierung: json['intervalldosierung'] as bool? ?? false,
  );
}

Map<String, dynamic> _$DosierungToJson(Dosierung instance) => <String, dynamic>{
      'futtername': instance.futtername,
      'portion': instance.portion,
      'tageslimit': instance.tageslimit,
      'pause': instance.pause,
      'fresszeit': instance.fresszeit,
      'teilpause': instance.teilpause,
      'teilportion': instance.teilportion,
      'intervalldosierung': instance.intervalldosierung,
    };
