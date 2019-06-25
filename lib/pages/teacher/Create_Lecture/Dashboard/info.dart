//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:smart_attendance/pages/home.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:smart_attendance/theme/style.dart';

//import 'package:smart_attendance/components/TextFields/inputField.dart';
//import 'package:smart_attendance/components/Buttons/textButton.dart';
//import 'package:smart_attendance/components/Buttons/roundedButton.dart';
import 'package:smart_attendance/services/validations.dart';
import 'package:smart_attendance/globals.dart' as globals;

class Info extends StatefulWidget {
  @override
  _InfoState createState() => new _InfoState();
}

class _InfoState extends State<Info> {
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  String _email, _password;
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  void showInSnackBar(String value) {
//    _scaffoldKey.currentState
//        .showSnackBar(new SnackBar(content: new Text(value)));
//  }

  bool autovalidate = false;
  Validations validations = new Validations();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: AppBar(
          title: Text('About Lecture'),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: <Widget>[
            Center (child: Text("Lecturer :-")),
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 56.0),
                title: Text('${globals.name}'),
                subtitle: Text('${globals.post}'),

              ),
            ),
            SizedBox(height: 40.0),
            Center (child: Text("Lecture Details :-")),

            Card(child: ListTile(title: Text("Course Code   :  ${globals.courseCode}"))),
            Card(child: ListTile(title: Text("Course Name  :  ${globals.courseName}"))),
            Card(child: ListTile(title: Text("Course Year :  ${globals.courseYear}"))),
            Card(child: ListTile(title: Text("Class Code  :  ${globals.classCode}"))),
            Card(child: ListTile(title: Text("Faculty  :  ${globals.faculty}"))),
            Card(child: ListTile(title: Text("Programe  :  ${globals.programme}"))),
            Card(child: ListTile(title: Text("Branch  :  ${globals.branch}"))),
            Card(child: ListTile(title: Text("Section  :  ${globals.sec}"))),
          ],
        )
    );
  }


}
