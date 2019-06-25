import "package:flutter/material.dart";
//import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:flutter/rendering.dart';
import 'package:smart_attendance/pages/student/Join_Lecture/scan.dart';
import 'package:smart_attendance/pages/student/Previous_Attendance/previous_attendance.dart';
import 'package:smart_attendance/pages/student/Profile/profile.dart';
import 'package:smart_attendance/globals.dart' as globals;
import 'package:smart_attendance/services/validations.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:smart_attendance/pages/welcome.dart';

class Student extends StatefulWidget {
  @override
  _StudentState createState() => new _StudentState();
}

class _StudentState extends State<Student> {
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  String _email, _password;
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  void showInSnackBar(String value) {
//    _scaffoldKey.currentState
//        .showSnackBar(new SnackBar(content: new Text(value)));
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
    _showDialog(context);
    return true;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

                Navigator.of(context).pop();
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

  bool autovalidate = false;
  Validations validations = new Validations();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Student Dashboard'),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScanScreen()),
                  );
                },
                textColor: Colors.white70,
                color: Colors.redAccent,
                child: new Text('Join Lecture')),
          ),
          new ListTile(
            title: new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
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

                onPressed: () {
                  Navigator.pop(context);
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
      ),
    );
  }
}
