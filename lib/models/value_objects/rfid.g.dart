// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rfid.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension RfidCopyWith on Rfid {
  Rfid copyWith({
    String? rfid,
  }) {
    return Rfid(
      rfid: rfid ?? this.rfid,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rfid _$RfidFromJson(Map<String, dynamic> json) {
  return Rfid(
    rfid: json['rfid'] as String,
  );
}

Map<String, dynamic> _$RfidToJson(Rfid instance) => <String, dynamic>{
      'rfid': instance.rfid,
    };
