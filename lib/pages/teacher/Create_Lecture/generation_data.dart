import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:smart_attendance/pages/screens/teacher/generate.dart';
import 'package:smart_attendance/pages/teacher/Create_Lecture/dashboard/lecture.dart';
import 'dart:convert';

import 'package:smart_attendance/globals.dart' as globals;
import 'package:xxtea/xxtea.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:async/async.dart';




class Generation extends StatefulWidget {
  @override
  _GenerationState createState() => _GenerationState();
}

class _GenerationState extends State<Generation> {
  String selectedClassCode;
//  = "Choose Class Code" ;
  String selectedCourseCode;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();



  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Do you want to start the lecture?"),

          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(

              child: new Text("No"),
              onPressed: () async {

                Navigator.of(context).pop();





              },
            ),
            new FlatButton(

              child: new Text("Yes"),
              onPressed: () async {

                Navigator.of(context).pop();
                addStudents(globals.studentId);




              },
            ),

          ],
        );
      },
    );
  }








  Future addStudents(List studentId) async{

    globals.currentCollection = "attendance"; //find a method to create new collection names,
    String currentCollection = globals.currentCollection;
    String collection1 = "users";
    String collection2 = "previous_lecture";
    String courseCode = globals.courseCode;
    String classCode = globals.classCode;
    String uid = globals.uid;
    String aid = globals.attendance_id;

    Map<String, String> qrDetail ={ "course_code" : courseCode,
      "attendance_id" : aid,
      "collection_name" : currentCollection,
      "class_code" : classCode,

    };



    DocumentReference qrId = await Firestore.instance.collection("class").document(classCode).collection("lectureID_qrCode").add(qrDetail);
    debugPrint("The New Document created with Id : ${qrId.documentID} ");

    globals.qrId = "${qrId.documentID}";
    globals.qrCode = xxtea.encryptToString(globals.qrId,globals.key);
    debugPrint(globals.qrCode);




    globals.studentDocumentId.clear();

    for (int i = 0; i < studentId.length; i++) {


      Map<String, String> map ={ "id" : studentId[i],
                  "attendance" : "Absent",
        "document" : "default"

      };



      DocumentReference docRef = await Firestore.instance.collection("attendance").document("${globals.attendance_id}").collection("attendance").add(map);
      debugPrint("The New Document created with Id : ${docRef.documentID} ");
      globals.studentDocumentId.insert(i, "${docRef.documentID}");
      Firestore.instance.collection("attendance").document("${globals.attendance_id}").collection("attendance").document("${docRef.documentID}").updateData({"document" : "${docRef.documentID}"});


    }















    Map<String, String> map ={ "time_stamp" : "${new DateTime.now()}",
      "course_code" : "$courseCode",
      "class_code" : "$classCode"

    };



    DocumentReference docRef = await Firestore.instance.collection("$collection1").document("$uid").collection("$collection2").add(map);
    debugPrint("The New Document created with Id : ${docRef.documentID} ");




    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Lecture()
                        ),
                        );



  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
//          leading: IconButton(
//              icon: Icon(
//                FontAwesomeIcons.bars,
//                color: Colors.white,
//              ),
//              onPressed: () {}),
          title: Container(
            alignment: Alignment.center,
            child: Text("Account Details",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(
//                FontAwesomeIcons.coins,
//                size: 20.0,
//                color: Colors.white,
//              ),
//              onPressed: null,
//            ),
//          ],
        ),
        body: Form(
          key: _formKeyValue,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[

              SizedBox(height: 40.0),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("class").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return new Container(width: 0.0, height: 0.0);
                    else {



//                      if((globals.requiredStudents > globals.studentId.length) || (globals.requiredStudents == 0)){
//                      globals.startAddingStudents = 1;}




                      List<DropdownMenuItem> classCodes = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        classCodes.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.documentID,
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

//                          Icon(FontAwesomeIcons.coins,
//                              size: 25.0, color: Color(0xff11b719)),
                          SizedBox(width: 50.0),
                          DropdownButton(




                            items: classCodes,
                            onChanged: (classCodeValue) {
                              globals.studentId.clear();
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected Class Code is $classCodeValue',
                                  style: TextStyle(color: Color(0xff11b719)),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedClassCode = classCodeValue;
                              });
                            },
                            value: selectedClassCode,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Class Code",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                  }),


              SizedBox(height: 40.0),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("course").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return new Container(width: 0.0, height: 0.0);
                    else {
                      List<DropdownMenuItem> courseCodes = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        courseCodes.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.documentID,
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
//                          Icon(FontAwesomeIcons.coins,
//                              size: 25.0, color: Color(0xff11b719)),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: courseCodes,
                            onChanged: (courseCodeValue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected Course Code is $courseCodeValue',
                                  style: TextStyle(color: Color(0xff11b719)),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCourseCode = courseCodeValue;
                              });
                            },
                            value: selectedCourseCode,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Course Code",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 150.0,
              ),
//              StreamBuilder<QuerySnapshot>(
//                  stream: Firestore.instance.collection(selectedClassCode).snapshots(),
//                  builder: (context, snapshot) {
//                    debugPrint("inside build but outside else if : with  class code $selectedClassCode ");
//                    if (!snapshot.hasData) {
//                      const Text("Loading.....");
//                      debugPrint("inside if   current studentId lenght : ${globals.studentId.length}");
//                      return new Container();
//                    }
//                    else if (globals.startAddingStudents ==1){
//                      debugPrint("inside else if: here length = ${snapshot.data.documents.length} : with  class code $selectedClassCode : and documents ${snapshot.data.documents}   current studentId lenght : ${globals.studentId.length}") ;
//
//
//                      for (int i = 0; i < snapshot.data.documents.length; i++) {
//                        DocumentSnapshot snap = snapshot.data.documents[i];
//                        globals.studentId.insert(i, "${snap.documentID}");
//                       debugPrint("added student $i ${snap.documentID}");
//                        debugPrint("current studentId lenght : ${globals.studentId.length}");
//                        debugPrint("current studentId var : ${globals.studentId}");
//
//                        globals.requiredStudents = snapshot.data.documents.length;
//                        globals.startAddingStudents =0;
//                      }
//                      return new Container();
//                    }
//
//                    else {
//                      debugPrint("nothing goes here : with  class code $selectedClassCode ");
//                      debugPrint("current studentId lenght : ${globals.studentId.length}");
//                      return new Container();
//                    }
//                    }),
//              SizedBox(
//                height: 10.0,
//              ),
//
                   RaisedButton(
                      color: Color(0xff11b719),
                      textColor: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Submit", style: TextStyle(fontSize: 24.0)),
                            ],
                          )),
                      onPressed: () async {
                        if (selectedCourseCode != null &&
                            selectedClassCode != "Choose Class Code") {


    final QuerySnapshot querySnapshot = await Firestore.instance.collection("$selectedClassCode").getDocuments();

    debugPrint(" length : ${querySnapshot.documents.length}");



    globals.studentId.clear();

    for (int i = 0; i < querySnapshot.documents.length; i++) {
    globals.studentId.insert(i, "${querySnapshot.documents[i].documentID}");
    }






    globals.classCode = selectedClassCode;
                            globals.courseCode = selectedCourseCode;
                            getClassDetails();
                            getCourseDetails();
                            globals.startAddingStudents = 0;

                            if (globals.studentId.length ==
                                globals.requiredStudents) {
                              _showDialog();
                            }
                            else {
                              debugPrint("Having problem");
                            }
                          }
                        }
                      ) ],
              ),

          ),
        );
  }
}

getClassDetails() async {
  debugPrint("Inside getClass func");

  DocumentSnapshot snapshot= await Firestore.instance.collection('class').document('${globals.classCode}').get();
  if (snapshot.data == null) {debugPrint("No data in class > classcode");}
  else{
  globals.branch = snapshot.data['branch'];
  debugPrint("See if the value of branch is set : ${globals.branch}");
  globals.faculty = snapshot.data['faculty'];
  globals.programme = snapshot.data['programme'];
  globals.sec = snapshot.data['sec'];
}}

getCourseDetails() async {
  debugPrint("Inside getCourse func");

  DocumentSnapshot snapshot= await Firestore.instance.collection('course').document('${globals.courseCode}').get();
  if (snapshot.data == null) {debugPrint("No data in course > coursecode");}
  else{
    globals.courseName = snapshot.data['name'];
    globals.courseYear = snapshot.data['year'];
  }}