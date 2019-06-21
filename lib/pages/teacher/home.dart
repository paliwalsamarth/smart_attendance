import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_attendance/pages/teacher/Profile/profile.dart';
import 'package:smart_attendance/pages/teacher/Previous_Lectures/previous_lectures.dart';
import 'package:smart_attendance/pages/teacher/Create_Lecture//generation_data.dart';
import 'package:smart_attendance/globals.dart' as globals;

//import 'package:smart_attendance/services/validations.dart';

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
                    checking(context);
                  },
                  textColor: Colors.white70,
                  color: Colors.redAccent,
                  child: new Text('Start Lecture')),
            ),
            new ListTile(
              title: new FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  textColor: Colors.white70,
                  color: Colors.redAccent,
                  child: new Text('Profile')),
            )
          ],
        ));
  }
}

checking(BuildContext context) async {



//  debugPrint(" length : ${globals.attendance_id}");
//  Firestore app = Firestore.instance;
  final QuerySnapshot querySnapshot = await Firestore.instance.collection("attendance").document(globals.attendance_id).collection("attendance").getDocuments();

  debugPrint(" length : ${querySnapshot.documents.length}");


  if (querySnapshot.documents.length > 1) {
    globals.extraStudentDocumentId.clear();

         for (int i = 0; i < querySnapshot.documents.length; i++) {
           globals.extraStudentDocumentId.insert(i, "${querySnapshot.documents[i].documentID}");
          }


//    List<DocumentSnapshot> list = querySnapshot.documents;
//  debugPrint(" length : ${globals.extraStudentDocumentId.length}");



    debugPrint("${globals.extraStudentDocumentId[0]}");

//                          await Firestore.instance.collection("attendance").document("${globals.attendance_id}").collection("attendance")
//                              .getDocuments()
//                              .then((snapshot) {
//                            List<DocumentSnapshot> list = snapshot.documents;
    debugPrint(" length : ${globals.extraStudentDocumentId.length}");

//        for (DocumentSnapshot ds in snapshot.documents){
//          ds.reference.delete();
//        }

//                            if (globals.extraStudentDocumentId.length > 1) {
//                              debugPrint("${list[1].documentID}");
//
//                          for (DocumentSnapshot ds in snapshot.documents){
////                            if (ds.documentID! = "-Lhnb1111default")
////                            {
//                              ds.reference.delete();
////                              }
//                          }

    for (int i = 1; i < globals.extraStudentDocumentId.length; i++) {
      debugPrint(" deleting ${globals.extraStudentDocumentId[i]}");
      Firestore.instance.collection("attendance").document("${globals.attendance_id}").collection("attendance").document(globals.extraStudentDocumentId[i]).delete();
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => Generation()),
    );

  }
  else{

    Navigator.push(context, MaterialPageRoute(builder: (context) => Generation()),
    );

  }





}