import 'package:smart_attendance/pages/Login/login1.dart';
//import 'package:xxtea/xxtea.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendance/globals.dart' as globals;
import 'package:smart_attendance/pages/student/home.dart';
import 'package:smart_attendance/pages/teacher//home.dart';
import 'dart:io';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Smart Attendance'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Space Left for app logo and background image"),
          RaisedButton(
            onPressed: checkNet,
            child: Text('Log in with Institute provided details'),

          ),

        ],
      ),
    );
  }


  Future checkNet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        navigateToSignIn();
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





  void navigateToSignIn(){


    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 4), content:
        new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text("  Signing-In...")
          ],
        ),
        ));


        debugPrint("Printing Role ${globals.role}");

        if (globals.role == 'admin') {
// Can be made after wards
        }
        else if (globals.role == "teacher") {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Teacher()),
          );


        }
        else if (globals.role == "student") {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Student()),
          );
        }
        else {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Login(), fullscreenDialog: true));
        }
      }









  }

