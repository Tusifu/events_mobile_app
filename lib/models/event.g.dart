// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    id: json['id'] as int,
    name: json['name'] as String,
    location: json['location'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    ratings: json['ratings'] as int,
  )
    ..participants = json['participants'] as List
    ..speakers = json['speakers'] as List;
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'date': instance.date?.toIso8601String(),
      'ratings': instance.ratings,
      'participants': instance.participants,
      'speakers': instance.speakers,
    };
