import 'package:event_frontend/pages/events.dart';
import 'package:event_frontend/pages/register.dart';
import 'package:event_frontend/services/events_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


void setupLocator(){
  GetIt.instance.registerLazySingleton(() => EventService());  
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor :  Color(0xFFE95123),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: Register(),
      home: Events()
    );
  }
}
