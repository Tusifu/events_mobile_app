import 'package:event_frontend/models/event.dart';
import 'package:event_frontend/models/participants.dart';
import 'package:event_frontend/services/events_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Register extends StatefulWidget {
  // final int id;
  // Register({this.id});

  // bool get isEditing => id != null;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  EventService get service => GetIt.I<EventService>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();

  static var _gender = ['Male', 'Female'];
  String _selected = 'Male';

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Write some code to control things, when user press Back navigation button in device navigationBar
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register For an event"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Write some code to control things, when user press back button in AppBar
                // moveToLastScreen();
              }),
        ),
        body: _isLoading ? Center(child:CircularProgressIndicator()) : Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // First Element
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: _nameController,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    // updateTitle();
                  },
                  decoration: InputDecoration(
                      labelText: 'name',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0))),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    // updateTitle();
                  },
                  decoration: InputDecoration(
                      labelText: 'email',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0))),
                ),
              ),

              // Second Element
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: _occupationController,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    // updateDescription();
                  },
                  decoration: InputDecoration(
                      labelText: 'Occupation',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0))),
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: dropDownGender()),

              // Third Element
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Register',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () async {

                          setState(() {
                            _isLoading = true;
                          });

                          final participant = Participant(
                              name: _nameController.text,
                              gender: 'Male',
                              email: _emailController.text,
                              occupation: _occupationController.text,
                              event: 1);

                          final result =
                              await service.registerForEvent(participant);

                          setState(() {
                            _isLoading = false;
                          });

                          final title = 'Done';
                          final text = result.error
                              ? (result.errorMessage ?? 'An error occured')
                              : 'you have been registered';

                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                      title: Text(title),
                                      content: Text(text),
                                      actions: [
                                        FlatButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ])
                                      
                                      ).then((data) {
                                        if(result.data){
                                          Navigator.of(context).pop();
                                        }
                                      })
                                      ;
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),

                    // Fourth element
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownGender() {
    return Expanded(
        child: DropdownButton<String>(
      items: _gender.map((String DropDownStringItem) {
        return DropdownMenuItem(
          value: DropDownStringItem,
          child: Text(DropDownStringItem),
        );
      }).toList(),
      onChanged: (String newValueSelected) {
        setState(() {
          this._selected = newValueSelected;
        });
      },
      value: _selected,
    ));
  }
}
