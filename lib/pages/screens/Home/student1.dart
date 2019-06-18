import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/rendering.dart';
import 'package:smart_attendance/pages/screens/student/scan.dart';
import 'package:smart_attendance/pages/screens/student/previous_attendance.dart';
import 'package:smart_attendance/pages/screens/student/profile.dart';
import 'package:smart_attendance/globals.dart' as globals;
import 'package:smart_attendance/services/validations.dart';


class Student extends StatefulWidget {
  @override
  _StudentState createState() => new _StudentState();
}

class _StudentState extends State<Student> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  void showInSnackBar(String value) {
//    _scaffoldKey.currentState
//        .showSnackBar(new SnackBar(content: new Text(value)));
//  }

  bool autovalidate = false;
  Validations validations = new Validations();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Student Dashboard'),
        ),
        body:
                    new ListView(
                      children: <Widget>[

                        new ListTile(
                          title: new FlatButton(

                              onPressed: () {

                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ScanScreen()),
                                );


                              },
                              textColor: Colors.white70,
                              color: Colors.redAccent,
                              child: new Text('Join Lecture')),
                        ),

                        new ListTile(
                          title: new FlatButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => PreviousAttendance()),
                                );
                              },
                              textColor: Colors.white70,
                              color: Colors.redAccent,
                              child: new Text('Previous Attendance')),
                        ),

                        new ListTile(
                          title: new FlatButton(
//                          onPressed: () {
//                            Navigator.push(context, MaterialPageRoute(
//                                builder: (context) => SecondRoute()),
//                            );
//                          },

                              onPressed: () {Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ProfilePage()),
                              );

                              },
                              textColor: Colors.white70,
                              color: Colors.redAccent,
                              child: new Text('Profile')),
                        )

                      ],
                    )
                  ,
                )


    ;
  }


}







