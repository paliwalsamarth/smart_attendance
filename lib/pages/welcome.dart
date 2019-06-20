import 'package:smart_attendance/pages/Login/login1.dart';
//import 'package:xxtea/xxtea.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendance/globals.dart' as globals;
import 'package:smart_attendance/pages/student/home.dart';
import 'package:smart_attendance/pages/teacher//home.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Attendance'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Space Left for app logo and background image"),
          RaisedButton(
            onPressed: navigateToSignIn,
            child: Text('Log in with Institute provided details'),

          ),

        ],
      ),
    );
  }

  void navigateToSignIn(){
        debugPrint("Printing Role ${globals.role}");

        if (globals.role == 'admin') {
// Can be made after wards
        }
        else if (globals.role == "teacher") {

          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Teacher()),
          );


        }
        else if (globals.role == "student") {

          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Student()),
          );
        }
        else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Login(), fullscreenDialog: true));
        }
      }









  }

