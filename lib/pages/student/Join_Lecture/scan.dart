import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_attendance/pages/student/Join_Lecture/Dashboard/lecture.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_attendance/globals.dart' as globals;
import 'package:xxtea/xxtea.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:smart_attendance/pages/student/home.dart';


String docId;

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

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

  void _showDialogWrong() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("You Scanned wrong QR Code. Contact the Lecturer."),

          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogTryAgain() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Oops! try again and hold your device correctly"),

          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//  @override
//  initState() {
//    super.initState();
//  }

  Future syncToPreviousAttendance() async {
    String collection1 = "users";
    String collection2 = "previous_attendance";
    String courseCode = globals.courseCode;
    String uid = globals.uid;


    var fireStore2 = Firestore.instance;


    Map<String, String> map = { "time_stamp": "${new DateTime.now()}",
      "course_code": "$courseCode"
    };


    DocumentReference docRef = await fireStore2.collection("$collection1")
        .document("$uid").collection("$collection2")
        .add(map);
    debugPrint("The New Document created with Id : ${docRef.documentID} ");


    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Lecture()
    ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text('Please Scan the QR CODE'),
          automaticallyImplyLeading: false,
        ),
        body: new Center(
          child: new ListView(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: checkNet,
                    child: const Text('Click here to scan QR code')
                ),
              )
              ,


            ],
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();

      setState(() => this.barcode = barcode);
//      String barcode = "-Li2ZkLdyHEK8ODe0xJM";

      String decrypt_data = xxtea.decryptToString(barcode, globals.key);
      debugPrint(decrypt_data);


      debugPrint("Decripting qr code");


      try {
        DocumentSnapshot snapshot = await Firestore.instance.collection("class")
            .document("${globals.clas}").collection("lectureID_qrCode")
            .document("$decrypt_data")
            .get();
        if (snapshot.data['class_code'] == "${globals.clas}") {

          _scaffoldKey.currentState.showSnackBar(
              new SnackBar(duration: new Duration(seconds: 20), content:
              new Row(
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Text("  Signing-In...")
                ],
              ),
              ));

          globals.courseCode = snapshot.data['course_code'];
          globals.currentCollection = snapshot.data['collection_name'];
          globals.attendance_id = snapshot.data['attendance_id'];
          getCourseDetails();


//          syncToPreviousAttendance();
        }
        else {
          debugPrint("Comparing global = ${globals.clas} : snapshot = ${snapshot
              .data['class_code']}");
          _showDialogWrong();
        }
      } catch (e) {
        print(e.message);

        _showDialogWrong();
      }


//      present.updating(barcode);

    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          _scaffoldKey.currentState.showSnackBar(
              new SnackBar(duration: new Duration(seconds: 4), content:
              new Row(
                children: <Widget>[
                  new Text("grant the camera permission!")
                ],
              ),
              ));

        });
      } else {
        setState(() {
          _scaffoldKey.currentState.showSnackBar(
              new SnackBar(duration: new Duration(seconds: 4), content:
              new Row(
                children: <Widget>[
                  new Text("Unknown error: $e")
                ],
              ),
              ));

        });

      }
    } on FormatException {
      setState(() {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(duration: new Duration(seconds: 4), content:
            new Row(
              children: <Widget>[
                new Text("Scanning not done correctly")
              ],
            ),
            ));

      });
    } catch (e) {
      setState(() {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(duration: new Duration(seconds: 4), content:
            new Row(
              children: <Widget>[
                new Text("Unknown error: $e")
              ],
            ),
            ));

      });
    }
  }


  getLecturerDetails() async {
    debugPrint("Inside getClass func");

    DocumentSnapshot snapshot = await Firestore.instance.collection(
        'attendance').document('${globals.attendance_id}').get();
    if (snapshot.data == null) {
      debugPrint("No data in class > classcode");
    }
    else {
      globals.lecturerName = snapshot.data['name'];
      globals.post = snapshot.data['post'];
      findAttendanceId();
    }
  }

  getCourseDetails() async {
    debugPrint("Inside getCourse func");

    DocumentSnapshot snapshot = await Firestore.instance.collection('course')
        .document('${globals.courseCode}')
        .get();
    if (snapshot.data == null) {
      debugPrint("No data in course > coursecode");
    }
    else {
      globals.courseName = snapshot.data['name'];
      globals.courseYear = snapshot.data['year'];
      getLecturerDetails();
    }
  }

  findAttendanceId() async {
    try {


      await Firestore.instance
          .collection("attendance")
          .document("${globals.attendance_id}")
          .collection("attendance")
          .where('id',
          isEqualTo: "${globals.id}").getDocuments().then((string) {
        string.documents.forEach((doc) async => globals.docId = doc.documentID);
      });

//      debugPrint(" $docId");
//      List docId1 = docId.split(",");
//      debugPrint(" $docId1");
//      String docId2 = docId1[0];
//      debugPrint(" $docId2");
//      List docId3 = docId2.split("-");
//      debugPrint(" $docId3");
//      globals.docId = "-${docId3[1]}";
      debugPrint(" ${globals.docId}");

      markPresent();
    }
    catch (e) {
      print('Caught Firestore exception2');
      print(e);
      _showDialogTryAgain();
    }
  }

  markPresent() async {
    try {
      await Firestore.instance
          .collection("attendance")
          .document("${globals.attendance_id}")
          .collection("attendance")
          .document("${globals.docId}")
          .updateData({"attendance": "Present"});


      await syncToPreviousAttendance();
    }
    catch (e) {
      print('Caught Firestore exception3');
      print(e);
      _showDialogTryAgain();
    }
  }


  Future checkNet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        scan();
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
}