import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_attendance/pages/teacher/Profile/profile.dart';
import 'package:smart_attendance/pages/teacher/Previous_Lectures/previous_lectures.dart';
import 'package:smart_attendance/pages/teacher/Create_Lecture//generation_data.dart';
import 'package:smart_attendance/globals.dart' as globals;
import 'package:back_button_interceptor/back_button_interceptor.dart';
//import 'package:smart_attendance/services/validations.dart';
import 'package:smart_attendance/pages/welcome.dart';

class Teacher extends StatefulWidget {
  @override
  _TeacherState createState() => new _TeacherState();
}

class _TeacherState extends State<Teacher> {
//  void showInSnackBar(String value) {
//    _scaffoldKey.currentState
//        .showSnackBar(new SnackBar(content: new Text(value)));
//  }



//  void _showDialogPastData(List<DocumentSnapshot> list) {
//    // flutter defined function
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text(
//              "Looks like previous session was not closed properly. Don't click back or exit while we are building a new session for you."),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Refresh"),
//              onPressed: ()  {
//
//
////                clearPastData(list);
////                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }




  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }



  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON!"); // Do some stuff.
//    _showDialog(context);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
    );
    return true;
  }



  void _showDialog(BuildContext pageContext) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Do you want to log out?"),

          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            new FlatButton(

              child: new Text("No"),
              onPressed: ()  {


                Navigator.of(context).pop();




              },
            ),
            new FlatButton(

              child: new Text("Yes"),
              onPressed: () async {

                _scaffoldKey.currentState.showSnackBar(
                    new SnackBar(duration: new Duration(seconds: 20), content:
                    new Row(
                      children: <Widget>[
                        new CircularProgressIndicator(),
                        new Text("  Loging-out...")
                      ],
                    ),
                    ));

                globals.qrCode = null;
                globals.classCode = null;
                globals.courseCode = null;
                globals.startAddingStudents = 0;
                globals.requiredStudents = 0;
                globals.post = null;
                globals.qrId = null;
                globals.attendance_id = null;
                globals.courseName = null;
                globals.courseYear= null;

                globals.studentId.clear();
                globals.studentDocumentId.clear();
                globals.attendanceDetails.clear();
                globals.extraStudentDocumentId.clear();


//for Students
                globals.id = null;
                globals.currentCollection = null;
                globals.key = "1234567890";
                globals.clas= null;
                globals.branch = null;
                globals.faculty= null;
                globals.programme= null;
                globals.sec=null;
                globals.uid=null;
                globals.name=null;
                globals.role=null;
                globals.lecturerName=null;
                globals.docId=null;

//Navigator.pop(pageContext);
                Navigator.pop(pageContext);
 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );

              },
            ),





          ],
        );
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text('Teacher Dashboard'),
          automaticallyImplyLeading: false,
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
                  onPressed: () async {


    try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
    {
//                                globals.studentId.clear();

      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(duration: new Duration(seconds: 20), content:
          new Row(
            children: <Widget>[
              new CircularProgressIndicator(),
              new Text("  Loading...")
            ],
          ),
          ));

      checkingPastStudentData(context);
    }
    } on SocketException catch (_) {
    debugPrint('not connected');

    _scaffoldKey.currentState.showSnackBar(
    new SnackBar(duration: new Duration(seconds: 4), content:
    new Row(
    children: <Widget>[
    new Text("Please check your internet connection!")
    ],
    ),
    ));
    }





    }
   ,
                  textColor: Colors.white70,
                  color: Colors.redAccent,
                  child: new Text('Start Lecture')),
            ),
            new ListTile(
              title: new FlatButton(
                  onPressed: () async {



    try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => PreviousLectures()),
    );

    }
    } on SocketException catch (_) {
    debugPrint('not connected');

    _scaffoldKey.currentState.showSnackBar(
    new SnackBar(duration: new Duration(seconds: 4), content:
    new Row(
    children: <Widget>[
    new Text("Please check your internet connection!")
    ],
    ),
    ));
    }}
    ,
                  textColor: Colors.white70,
                  color: Colors.redAccent,
                  child: new Text('Previous Lectures')),
            ),
            new ListTile(
              title: new FlatButton(
                  onPressed: () async {
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      }
                    } on SocketException catch (_) {
                      debugPrint('not connected');

                      _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(
                            duration: new Duration(seconds: 4), content:
                          new Row(
                            children: <Widget>[
                              new Text("Please check your internet connection!")
                            ],
                          ),
                          ));
                    }
                  },
                  textColor: Colors.white70,
                  color: Colors.redAccent,
                  child: new Text('Profile')),
            )
          ],
        ));
  }
}

checkingPastStudentData(BuildContext context) async {

  final QuerySnapshot querySnapshot = await Firestore.instance.collection("attendance").document(globals.attendance_id).collection("attendance").getDocuments();

  debugPrint(" length : ${querySnapshot.documents.length}");


  if (querySnapshot.documents.length > 1) {
    globals.extraStudentDocumentId.clear();

         for (int i = 0; i < querySnapshot.documents.length; i++) {
           globals.extraStudentDocumentId.insert(i, "${querySnapshot.documents[i].documentID}");
          }
      debugPrint("${globals.extraStudentDocumentId[0]}");

    debugPrint(" length : ${globals.extraStudentDocumentId.length}");

    for (int i = 1; i < globals.extraStudentDocumentId.length; i++) {
      debugPrint(" deleting ${globals.extraStudentDocumentId[i]}");
      Firestore.instance.collection("attendance").document("${globals.attendance_id}").collection("attendance").document(globals.extraStudentDocumentId[i]).delete();
    }
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Generation()),
    );


  }
  else{
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Generation()),
    );

  }





}


