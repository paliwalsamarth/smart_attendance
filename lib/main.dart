import 'package:smart_attendance/pages/setup/welcome.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendance/globals.dart' as globals;

void main() {
  globals.qrCode = null;
globals.classCode = null;
globals.courseCode = null;
globals.startAddingStudents = null;
globals.requiredStudents = 0;
globals.studentId.clear();
globals.currentCollection = null;
globals.key = "1234567890";


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