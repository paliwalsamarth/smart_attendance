import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_attendance/globals.dart' as globals;

class PreviousAttendance extends StatefulWidget {

  const PreviousAttendance({ Key key }) : super(key: key);


  @override
  PreviousAttendanceState createState() => new PreviousAttendanceState();

}

class PreviousAttendanceState extends State<PreviousAttendance>{

  PreviousAttendanceState({Key key, this.user});
  final FirebaseUser user;

  String collection1 = "users";
  String collection2 = "previous_attendance";
  String uid = globals.uid;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Attended Lectures')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    debugPrint("inside _buildBody");
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('$collection1').document('$uid').collection('$collection2').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);


    return Padding(
      key: ValueKey(record.time_stamp),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text("Lecture Subject : ${record.course_code}"),
          subtitle: Text("Attended on ${record.time_stamp}"),



        ),
      ),
    );
  }


}

class Record {
  final String time_stamp;
  final String course_code;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['time_stamp'] != null),
        assert(map['course_code'] != null),
        time_stamp = map['time_stamp'],
        course_code = map['course_code'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

//  @override
//  String toString() => "Record<$lecture_number:$attendance>";
}