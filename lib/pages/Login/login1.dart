import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:smart_attendance/pages/student/home.dart';
import 'package:smart_attendance/pages/teacher//home.dart';
import 'package:smart_attendance/pages/welcome.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:smart_attendance/theme/style.dart';
import 'style.dart';
import 'package:smart_attendance/components/TextFields/inputField.dart';
import 'package:smart_attendance/components/Buttons/textButton.dart';
import 'package:smart_attendance/components/Buttons/roundedButton.dart';
import 'package:smart_attendance/services/validations.dart';
import 'package:smart_attendance/globals.dart' as globals;
import 'package:back_button_interceptor/back_button_interceptor.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}


class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );
    return true;
  }
//  void showInSnackBar(String value) {
//    _scaffoldKey.currentState
//        .showSnackBar(new SnackBar(content: new Text(value)));
//  }

  bool autovalidate = false;
  Validations validations = new Validations();

  checkRole() async {
    debugPrint("Inside getStud func");

    DocumentSnapshot snapshot = await Firestore.instance
        .collection('users')
        .document('${globals.uid}')
        .get();
    if (snapshot.data == null) {
      debugPrint("No data in users uid");
    } else {
      if (snapshot.data['role'] == 'admin') {
// Can be made after wards
      } else if (snapshot.data['role'] == 'teacher') {
        globals.name = snapshot.data['name'];
        globals.post = snapshot.data['post'];
        globals.role = snapshot.data['role'];
        globals.attendance_id = snapshot.data['attendance_id'];
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Teacher()),
        );
      } else if (snapshot.data['role'] == 'student') {
        globals.clas = snapshot.data['class'];
        globals.name = snapshot.data['name'];
        globals.id = snapshot.data['id'];
        globals.role = snapshot.data['role'];
        debugPrint("Reached getStud func");
        getStud();
        debugPrint("Passes getStud func");
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Student()),
        );
      } else {
        debugPrint("No data");
      }
    }
  }

  getStud() async {
    debugPrint("Inside getStud func");

    DocumentSnapshot snapshot = await Firestore.instance
        .collection('class')
        .document('${globals.clas}')
        .get();
    if (snapshot.data == null) {
      debugPrint("No data in class > classcode");
    } else {
      globals.branch = snapshot.data['branch'];
      debugPrint("See if the value of branch is set : ${globals.branch}");
      globals.faculty = snapshot.data['faculty'];
      globals.programme = snapshot.data['programme'];
      globals.sec = snapshot.data['sec'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              new InputField(
                hintText: "Email",
                obscureText: false,
                textInputType: TextInputType.text,
                textStyle: textStyle,
                textFieldColor: textFieldColor,
                icon: Icons.mail_outline,
                iconColor: Colors.black,
                bottomMargin: 20.0,
                validateFunction: validations.validateEmail,
                onSaved: (input) => _email = input,
              ),
              new InputField(
                hintText: "Password",
                obscureText: true,
                textInputType: TextInputType.text,
                textStyle: textStyle,
                textFieldColor: textFieldColor,
                icon: Icons.lock_open,
                iconColor: Colors.black,
                bottomMargin: 30.0,
                validateFunction: validations.validatePassword,
                onSaved: (input) => _password = input,
              ),

//              TextFormField(
////                validator: (input) {
////                  if (input.isEmpty) {
////                    return 'Provide an email';
////                  }
////                },
//                decoration: InputDecoration(labelText: 'Email'),
//
//                onSaved: (input) => _email = input,
//              ),

              new RoundedButton(
                buttonName: "Get Started",
                onTap: signIn,
                width: screenSize.width,
                height: 50.0,
                bottomMargin: 10.0,
                borderWidth: 0.0,
                buttonColor: primaryColor,
              ),
            ],
          )),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {



        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);

        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(duration: new Duration(seconds: 20), content:
            new Row(
              children: <Widget>[
                new CircularProgressIndicator(),
                new Text("  Loging-In...")
              ],
            ),
            ));
        globals.uid = user.uid;
        debugPrint("printing uid   ${globals.uid}");
        checkRole();
        debugPrint("Role checking done");
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(duration: new Duration(seconds: 4), content:
            new Row(
              children: <Widget>[

                new Text("Invalid email id or password entered"),
              ],
            ),
            ));
        print(e.message);

//        showInSnackBar(e.message.toString());
      }
    }
  }
}
