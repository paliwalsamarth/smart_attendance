import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/rendering.dart';
import 'package:smart_attendance/pages/screens/student/scan.dart';
import 'package:smart_attendance/pages/screens/student/previous_attendance.dart';
import 'package:smart_attendance/pages/screens/student/profile.dart';
import 'package:smart_attendance/globals.dart' as globals;


Center studentPage(DocumentSnapshot snapshot,BuildContext context) {

  return Center(



            child: new Stack(
              children: <Widget>[
//                new Center(
//                  child: new Image.asset(
//                    'images/white_snow.png',
//                    width: 490.0,
//                    height: 1200.0,
//                    fit: BoxFit.fill,
//                  ),
//                ),

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
              ],
            ));
  }


  class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text("Second Route"),
  ),
  body: Center(
  child: RaisedButton(
  onPressed: () {
  // Navigate back to first route when tapped.
  },
  child: Text('Go back!'),
  ),
  ),
  );
  }

  }
