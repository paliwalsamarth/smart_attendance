import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_attendance/pages/screens/teacher/profile.dart';
import 'package:smart_attendance/pages/screens/teacher/previous_lectures.dart';
import 'package:smart_attendance/pages/screens/teacher/generation_data.dart';
import 'package:smart_attendance/globals.dart' as globals;



import 'package:smart_attendance/services/validations.dart';


class Teacher extends StatefulWidget {
  @override
  _TeacherState createState() => new _TeacherState();
}

class _TeacherState extends State<Teacher> {


//  void showInSnackBar(String value) {
//    _scaffoldKey.currentState
//        .showSnackBar(new SnackBar(content: new Text(value)));
//  }



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Teacher Dashboard'),
        ),
        body:

//          new Center(
////            child: new Image.asset(
////              'images/white_snow.png',
////              width: 490.0,
////              height: 1200.0,
////              fit: BoxFit.fill,
////            ),
//          ),

                    new ListView(
                      children: <Widget>[

                        new ListTile(
                          title: new FlatButton(
                              onPressed: () {
//                                globals.studentId.clear();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Generation()),
                                );
                              },
                              textColor: Colors.white70,
                              color: Colors.redAccent,
                              child: new Text('Start Lecture')),
                        ),

                        new ListTile(
                          title: new FlatButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => PreviousLectures()),
                                );
                              },
                              textColor: Colors.white70,
                              color: Colors.redAccent,
                              child: new Text('Previous Lectures')),
                        ),

                        new ListTile(
                          title: new FlatButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ProfilePage()),
                                );
                              },
                              textColor: Colors.white70,
                              color: Colors.redAccent,
                              child: new Text('Profile')),
                        )

                      ],
                    )

    );
  }


}





