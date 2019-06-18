import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_attendance/pages/screens/Home/student.dart';
import 'package:smart_attendance/pages/screens/Home/admin.dart';
import 'package:smart_attendance/pages/screens/Home/teacher.dart';
import 'package:smart_attendance/globals.dart' as globals;

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

var name;
var year;

class _InfoState extends State<Info> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body:
        displayCourseDetails(context),
    );
  }

  Center displayCourseDetails( BuildContext context) {

    getClassDetails();
    return Center(
        child: Column(
          children: <Widget>[
            Text("Course code : ${globals.courseCode}"),
            Text("Course name : $name"),
            Text("Course year : $year"),
            Text("Class code : ${globals.classCode}"),
            Text("Faculty : ${globals.faculty}"),
            Text("Program : ${globals.programme}"),
            Text("Branch : ${globals.branch}"),
            Text("Section : ${globals.sec}"),
          ],
        )


    );
  }


}



getClassDetails() async {
  debugPrint("Inside getStud func");

  DocumentSnapshot snapshot= await Firestore.instance.collection('course').document('${globals.courseCode}').get();
  if (snapshot.data == null) {debugPrint("No data in class > classcode");}
  else{

    name = snapshot.data['name'];
    year = snapshot.data['year'];
  }}


