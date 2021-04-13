import 'dart:convert';

import 'package:event_frontend/models/api_response.dart';
import 'package:event_frontend/models/event.dart';
import 'package:event_frontend/models/participants.dart';
import 'package:http/http.dart' as http;

class EventService {
  static const url = "http://10.0.2.2:8000/api";
  static const headers = {'Content-Type': 'Application/json'};

  Future<APIResponse<List<Event>>> getEvents() {
    return http
        .get(
      url + '/events',
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Event>[];
        for (var item in jsonData) {
          events.add(Event.fromJson(item));
        }
        return APIResponse<List<Event>>(data: events);
      }
      return APIResponse<List<Event>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Event>>(
            error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Event>> getEvent(int id) {
    return http
        .get(
      url + '/events/' + id.toString(),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Event>(data: Event.fromJson(jsonData));
      }
      return APIResponse<Event>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<Event>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> registerForEvent(Participant participant) {
    return http
        .post(url + '/participants/create',
            body: json.encode(participant.toJson()), headers: headers)
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}
