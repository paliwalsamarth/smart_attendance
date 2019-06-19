import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_attendance/pages/screens/student/lecture.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_attendance/globals.dart' as globals;
import 'package:xxtea/xxtea.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

  void _showDialog() {
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

  @override
  initState() {
    super.initState();
  }

  Future syncToPreviousAttendance() async{


    String collection1 = "users";
    String collection2 = "previous_attendance";
    String courseCode = globals.courseCode;
    String uid = globals.uid;







    var fireStore2 = Firestore.instance;



      Map<String, String> map ={ "time_stamp" : "${new DateTime.now()}",
        "course_code" : "$courseCode"

      };



      DocumentReference docRef = await fireStore2.collection("$collection1").document("$uid").collection("$collection2").add(map);
      debugPrint("The New Document created with Id : ${docRef.documentID} ");



    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Lecture()
    ),
    );



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Please Scan the QR CODE'),
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
                    onPressed: scan,
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

      String decrypt_data = xxtea.decryptToString(barcode,globals.key);
      debugPrint(decrypt_data);



        debugPrint("Decripting qr code");



      try {

        DocumentSnapshot snapshot= await Firestore.instance.collection("class").document("${globals.clas}").collection("lectureID_qrCode").document("$decrypt_data").get();
        if (snapshot.data['class_code'] == "${globals.clas}")
        {
          globals.courseCode = snapshot.data['course_code'];
          globals.currentCollection = snapshot.data['collection_name'];
          globals.attendance_id = snapshot.data['attendance_id'];
          syncToPreviousAttendance();
        }
        else
        {debugPrint("Comparing global = ${globals.clas} : snapshot = ${snapshot.data['class_code']}");
        _showDialog();

        }



      } catch (e) {
        print(e.message);

        _showDialog();
      }









//      present.updating(barcode);

    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}