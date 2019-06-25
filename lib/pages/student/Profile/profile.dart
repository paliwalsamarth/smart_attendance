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
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:smart_attendance/pages/student/home.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Student()),
    );
    return true;
  }


  bool autovalidate = false;
  Validations validations = new Validations();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text('${globals.name}'),
              subtitle: Text('Click to update photo'),

            ),
          ),
          SizedBox(height: 40.0),
          Center (child: Text("User Details :-")),

          Card(child: ListTile(title: Text("Under faculty   :  ${globals.faculty}"))),
          Card(child: ListTile(title: Text("Programme  :  ${globals.programme}"))),
          Card(child: ListTile(title: Text("Branch  :  ${globals.branch}"))),
          Card(child: ListTile(title: Text("Class  :  ${globals.clas}"))),
          Card(child: ListTile(title: Text("Section  :  ${globals.sec}"))),
          Card(child: ListTile(title: Text("Student Id  :  ${globals.id}"))),
        ],
      )
    );
  }


}
