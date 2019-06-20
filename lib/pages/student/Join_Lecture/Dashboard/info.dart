import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:smart_attendance/pages/screens/Home/student.dart';
//import 'package:smart_attendance/pages/screens/Home/admin.dart';
//import 'package:smart_attendance/pages/teacher/home.dart';
import 'package:smart_attendance/globals.dart' as globals;

class Info extends StatelessWidget {
  const Info({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  get context => BuildContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body:

      StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('course')
            .document(globals.courseCode)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return displayCourseDetails(snapshot.data,context);
          }
          return LinearProgressIndicator();
        },
      ),


    );
  }

  Center displayCourseDetails(DocumentSnapshot snapshot,BuildContext context) {
    if (snapshot.data == null) {
      return Center(
        child: Text('no data set in the class details in firestore'),
      );
    }
    return Center(
        child: Column(
          children: <Widget>[
            Text("Course code : ${globals.courseCode}"),
            Text("Course name : ${snapshot.data['name']}"),
            Text("Course year : ${snapshot.data['year']}"),
            Text("Class code : ${globals.classCode}"),
            Text("Faculty : ${globals.faculty}"),
            Text("Program : ${globals.programme}"),
            Text("Branch : ${globals.branch}"),
            Text("Section : ${globals.sec}"),
          ],
        )


    );}




}
