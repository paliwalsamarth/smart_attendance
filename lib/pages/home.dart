import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_attendance/pages/screens/Home/student.dart';
import 'package:smart_attendance/pages/screens/Home/admin.dart';
import 'package:smart_attendance/pages/screens/Home/teacher.dart';
import 'package:smart_attendance/globals.dart' as globals;

class Home extends StatelessWidget {
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  get context => BuildContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('users')
            .document(user.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return checkRole(snapshot.data,context);
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }

  Center checkRole(DocumentSnapshot snapshot,BuildContext context) {
    if (snapshot.data == null) {
      return Center(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (snapshot.data['role'] == 'admin'){

      return adminPage(snapshot,context);}
     else if (snapshot.data['role'] == 'teacher') {
      return teacherPage(snapshot,context);}
    else if (snapshot.data['role'] == 'student') {
      globals.clas = snapshot.data['class'];
      globals.id = snapshot.data['id'];
      debugPrint("Reached getStud func");
      getStud();
      debugPrint("Passes getStud func");
      return studentPage(snapshot,context);}
    else {
                debugPrint("No data");
              }
    }




  }



getStud() async {
  debugPrint("Inside getStud func");

  DocumentSnapshot snapshot = await Firestore.instance.collection('class')
      .document('${globals.clas}')
      .get();
  if (snapshot.data == null) {
    debugPrint("No data in class > classcode");
  }
  else {
    globals.branch = snapshot.data['branch'];
    debugPrint("See if the value of branch is set : ${globals.branch}");
    globals.faculty = snapshot.data['faculty'];
    globals.programme = snapshot.data['programme'];
    globals.sec = snapshot.data['sec'];
  }
}
