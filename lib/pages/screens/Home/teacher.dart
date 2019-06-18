import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_attendance/pages/screens/teacher/previous_lectures.dart';
import 'package:smart_attendance/pages/screens/teacher/generation_data.dart';
import 'package:smart_attendance/globals.dart' as globals;


Center teacherPage(DocumentSnapshot snapshot, BuildContext context) {

  return Center(

      child: new Stack(
        children: <Widget>[
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
                      globals.studentId.clear();
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
                          builder: (context) => SecondRoute()),
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







//