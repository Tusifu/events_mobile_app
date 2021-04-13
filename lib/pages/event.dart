import 'package:event_frontend/models/api_response.dart';
import 'package:event_frontend/models/event.dart';
import 'package:event_frontend/models/participants.dart';
import 'package:event_frontend/services/events_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EventPage extends StatefulWidget {
  final int id;
  EventPage({this.id});
  bool get isEditing => id != null;

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  EventService get service => GetIt.I<EventService>();

  String errorMessage = '';

  // declare empty variables to hold some backend values
  String eventName = '';
  String location = '';
  int ratings = 0;
  String date;
  List<dynamic> participants;
  List<dynamic> speakers;

  Event event;

  @override
  void initState() {
    _getNote();
    super.initState();
  }

  _getNote() {
    service.getEvent(widget.id).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error Message';
      }
      event = response.data;

      setState(() {
        eventName = event.name;
        location = event.location;
        ratings = event.ratings;
        date = formatDateTime(event.date);
        participants = event.participants;
        speakers = event.speakers;
      });

      print('the rating for this particular event $ratings');
    });
  }

// Method to format the dateTime and return a string format
  String formatDateTime(DateTime datetime) {
    return '${datetime.day}-${datetime.month}-${datetime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Event Detail'),
        ),
        body: Column(
          children: [
            // 1st column child
            Row(children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(eventName),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 10.0, left: 90.0, bottom: 10.0, right: 10.0),
                child: Center(
                  child: Text(location),
                ),
              ),
            ]),

            Container(
              height: 20.0,
            ),

            // 2nd column child

            // Row(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.all(10.0),
            //       child: ListView.builder(
            //         itemCount: participants.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return ListTile(
            //             leading: CircleAvatar(
            //               child: Text('${widget.id}'),
            //             ),
            //             title: Text('Participant name:'),
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // )
          ],
        ));
  }

  // Method to return icons depending on the ratings of the event.

  // IconData _ratingsIcon(){
  //   if (ratings ==1){
  //     return Icons.star;
  //   }
  // }
}
