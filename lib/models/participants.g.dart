// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participants.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participant _$ParticipantFromJson(Map<String, dynamic> json) {
  return Participant(
    id: json['id'] as int,
    name: json['name'] as String,
    gender: json['gender'] as String,
    email: json['email'] as String,
    occupation: json['occupation'] as String,
    event: json['event'] as int,
  );
}

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'email': instance.email,
      'occupation': instance.occupation,
      'event': instance.event,
    };
