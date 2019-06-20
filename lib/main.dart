import 'package:smart_attendance/pages/welcome.dart';
import 'package:flutter/material.dart';
//import 'package:smart_attendance/globals.dart' as globals;

void main() {

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}