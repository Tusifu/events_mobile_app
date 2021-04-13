import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:event_frontend/models/api_response.dart';
import 'package:event_frontend/models/event.dart';
import 'package:event_frontend/pages/event.dart';
import 'package:event_frontend/pages/event_delete.dart';
import 'package:event_frontend/pages/register.dart';
import 'package:event_frontend/services/events_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import 'package:note_api/models/api_response.dart';
// import 'package:note_api/models/note_for_listing.dart';
// import 'package:note_api/services/notes_services.dart';
// import 'package:note_api/views/note_delete.dart';

// import 'note_modify.dart';

class Events extends StatefulWidget {
  Events({Key key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  EventService get service => GetIt.I<EventService>();
  APIResponse<List<Event>> _apiResponse;
  bool _isLoading = false;

  // EventService note = new EventService();

  int _currentIndex = 0;

  @override
  void initState() {
    _fetchEvents();
    super.initState();
  }

  _fetchEvents() async {
    setState(() {
      _isLoading = true;
    });

    // notes = note.getEvent();
    _apiResponse = await service.getEvents();

    setState(() {
      _isLoading = false;
    });
  }

  String formatDateTime(DateTime datetime) {
    return '${datetime.day}-${datetime.month}-${datetime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EVENTS APP'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                tooltip: 'Register',
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Register()))
                      .then((_) => _fetchEvents());
                })
          ],
        ),

        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add, color: Colors.white,),
        //   backgroundColor: Theme.of(context).primaryColor,
        //   onPressed: () {
        //     Navigator.of(context)
        //         .push(MaterialPageRoute(builder: (_) => Register())).then((_) => _fetchEvents());
        //   },
        // ),

        //CURVED NAVIGATION BAR

        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Color(0xFFE95123),
          buttonBackgroundColor: Color(0xFFE95123),
          height: 60,
          items: <Widget>[
            Icon(
              Icons.home,
              size: 25,
              color: Colors.white,
            ),
            Icon(
              Icons.camera,
              size: 25,
              color: Colors.white,
            ),
            Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),
            Icon(
              Icons.list,
              size: 25,
              color: Colors.white,
            ),
            Icon(
              Icons.logout,
              size: 25,
              color: Colors.white,
            ),
          ],
          index: 2,
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.bounceInOut,
          onTap: (index) {
            //Handle button tap
          },
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: ValueKey(_apiResponse.data[index].id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {},
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: context, builder: (_) => EventDelete());
                      return result;
                    },
                    background: Container(
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.only(right: 16.0),
                      child: Align(
                          child: Icon(Icons.delete, color: Colors.white),
                          alignment: Alignment.centerRight),
                    ),
                    child: ListTile(
                      title: Text(_apiResponse.data[index].name),
                      subtitle: Text(
                          'date: ${formatDateTime(_apiResponse.data[index].date ?? _apiResponse.data[index].date)}'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                EventPage(id: _apiResponse.data[index].id)));
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Color(0xFFE95123)),
                itemCount: _apiResponse.data.length,
              ));
  }

  Widget bottomWidget() {}
}
