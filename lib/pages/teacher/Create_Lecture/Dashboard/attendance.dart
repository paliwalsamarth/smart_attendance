import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_attendance/globals.dart' as globals;

class Attendance extends StatefulWidget {

  const Attendance({ Key key }) : super(key: key);


  @override
  AttendanceState createState() => new AttendanceState();

}

class AttendanceState extends State<Attendance>{

  AttendanceState({Key key, this.user});
  final FirebaseUser user;
  var currentCollection = globals.currentCollection;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Live Attendance'),
        automaticallyImplyLeading: false,),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    debugPrint("inside _buildBody");
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('attendance').document("${globals.attendance_id}").collection("attendance").snapshots(),
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
      key: ValueKey(record.id),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text("${record.id}  : ${record.attendance}"),


          onTap: () => record.reference.updateData(
              {
            'attendance': tongle(record.attendance) }

            ),
        ),
      ),
    );
  }

  String tongle(String attendance) {
    if(attendance == "Absent") {
      return "Present";
    }
    else if(attendance == "Present") { return "Absent"; }
    else return "Present / Absent";
  }
}

class Record {
  final String id;
  final String attendance;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['attendance'] != null),
        id = map['id'],
        attendance = map['attendance'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

//  @override
//  String toString() => "Record<$id:$attendance>";
}