import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event{
  int id;
  String name;
  String location;
  DateTime date;
  int ratings;
  List<dynamic> participants;
  List<dynamic> speakers;

Event({this.id, this.name, this.location, this.date, this.ratings});

factory Event.fromJson(Map<String, dynamic> data) => _$EventFromJson(data);

Map<String, dynamic> toJson() => _$EventToJson(this);

}