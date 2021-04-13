import 'package:event_frontend/models/event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'participants.g.dart';

@JsonSerializable(explicitToJson: true)
class Participant {
  int id;
  String name;
  String gender;
  String email;
  String occupation;
  int event;

  Participant(
      {this.id,
      this.name,
      this.gender,
      this.email,
      this.occupation,
      this.event});

  factory Participant.fromJson(Map<String, dynamic> data) => _$ParticipantFromJson(data);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}
