import 'package:flutter/material.dart';
import 'package:smart_attendance/pages/screens/student/info.dart';
import 'package:smart_attendance/pages/screens/student/later.dart';
import 'package:smart_attendance/pages/screens/student/present.dart';

class Lecture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LectureState();
  }
}
class LectureState extends State<Lecture> {
  int _selectedTab = 0;
  final _pageOptions = [
    Present(),
    Info(),
    LaterPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          )),
      home: Scaffold(

        body: _pageOptions[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text('ATTENDANCE'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('INFO'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.update),
              title: Text('CHAT'),
            ),
          ],
        ),
      ),
    );
  }}