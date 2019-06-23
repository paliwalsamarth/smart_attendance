import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendance/pages/teacher/Create_Lecture/dashboard/info.dart';
import 'package:smart_attendance/pages/teacher/Create_Lecture/dashboard/attendance.dart';
import 'package:smart_attendance/pages/teacher/Create_Lecture/dashboard/generate.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:smart_attendance/pages//teacher/home.dart';
import 'package:smart_attendance/globals.dart' as globals;

import 'package:smart_attendance/pages/teacher/Create_Lecture/dashboard/save_attendance.dart';







class Lecture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LectureState();
  }
}
class LectureState extends State<Lecture> {

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
    _showDialog();
    return true;
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Do you want to stop attendance of this lecture?"),

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

                Firestore.instance.collection("class").document("${globals.classCode}").collection("lectureID_qrCode").document("${globals.qrId}").delete();



        for (int i = 0; i < globals.studentDocumentId.length; i++) {
          Firestore.instance.collection("attendance").document("${globals.attendance_id}")
              .collection("attendance").document(globals.studentDocumentId[i])
              .delete();

        }



//                Firestore.instance.collection('attendance').document("${globals.attendance_id}").collection("attendance").getDocuments().then((snapshot) {
//                  for (DocumentSnapshot ds in snapshot.documents){
//                    ds.reference.delete();
//                  }});
//
//
//                Map<String, String> map ={ "id" : "Enrollment No.",
//                  "attendance" : "Present / Absent"
//
//                };
//
//                DocumentReference docRef = await Firestore.instance.collection("attendance").document("${globals.attendance_id}").collection("attendance").add(map);
//                debugPrint("The New Document created with Id : ${docRef.documentID} ");
//
//
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Teacher()),
                );








              },
            ),





          ],
        );
      },
    );
  }



  int _selectedTab = 0;
  final _pageOptions = [
    GenerateScreen(),
    Info(),
    Attendance(),
    SaveAttendance(),
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
        appBar : AppBar(
            title: Text("Click Icon to stop attendance"),
            backgroundColor: Colors.red,
            actions: <Widget>[
        // action button
        IconButton(

        icon: Icon(Icons.close),
        onPressed: () {
          _showDialog();
        },
      ),]),
        body: _pageOptions[_selectedTab],
        bottomNavigationBar: new Theme(
    data: Theme.of(context).copyWith(
    // sets the background color of the `BottomNavigationBar`
    canvasColor: Colors.green,
    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
    primaryColor: Colors.red,
    textTheme: Theme
        .of(context)
        .textTheme
        .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child : new BottomNavigationBar(

          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('QR CODE'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text('INFO'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('ATTENDENCE'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_download),

              title: Text('DOWNLOAD'),
            ),
          ],
        ),
      ),
    ));
  }}