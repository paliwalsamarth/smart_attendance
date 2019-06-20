//import "package:flutter/material.dart";
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//
//Center adminPage(DocumentSnapshot snapshot,BuildContext context) {
//
//  return Center(
//
//      child: new Stack(
//        children: <Widget>[
////          new Center(
////            child: new Image.asset(
////              'images/white_snow.png',
////              width: 490.0,
////              height: 1200.0,
////              fit: BoxFit.fill,
////            ),
////          ),
//
//          new ListView(
//            children: <Widget>[
//
//              new ListTile(
//                title: new FlatButton(
//                    onPressed: () {
//
//                      Navigator.push(context, MaterialPageRoute(
//                          builder: (context) => SecondRoute()),
//                      );
//                    },
//                    textColor: Colors.white70,
//                    color: Colors.redAccent,
//                    child: new Text('View Users')),
//              ),
//
//              new ListTile(
//                title: new FlatButton(
//                    onPressed: () {
//                      Navigator.push(context, MaterialPageRoute(
//                          builder: (context) => SecondRoute()),
//                      );
//                    },
//                    textColor: Colors.white70,
//                    color: Colors.redAccent,
//                    child: new Text('Edit User Detail')),
//              ),
//
//              new ListTile(
//                title: new FlatButton(
//                    onPressed: () {
//                      Navigator.push(context, MaterialPageRoute(
//                          builder: (context) => SecondRoute()),
//                      );
//                    },
//                    textColor: Colors.white70,
//                    color: Colors.redAccent,
//                    child: new Text('Create Users')),
//              )
//
//            ],
//          )
//        ],
//      ));
//}
//
//
//class SecondRoute extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Second Route"),
//      ),
//      body: Center(
//        child: RaisedButton(
//          onPressed: () {
//            // Navigate back to first route when tapped.
//          },
//          child: Text('Go back!'),
//        ),
//      ),
//    );
//  }
//
//}
//
//
////class HomeScreen extends StatefulWidget {
////
////  const HomeScreen({ Key key }) : super(key: key);
////
////
////  @override
////  HomeScreenState createState() => new HomeScreenState();
////
////}
////
////class HomeScreenState extends State<HomeScreen>{
////
//////  HomeScreenState({Key key, this.user});
//////  final FirebaseUser user;
////
////
////  @override
////  Widget build(BuildContext context) {
////    // TODO: implement build
////    return Scaffold(
////      appBar: AppBar(title: Text('Baby Name Votes')),
////      body: _buildBody(context),
////    );
////  }
////
////  Widget _buildBody(BuildContext context) {
////    return StreamBuilder<QuerySnapshot>(
////      stream: Firestore.instance.collection('users').snapshots(),
////      builder: (context, snapshot) {
////        if (!snapshot.hasData) return LinearProgressIndicator();
////
////        return _buildList(context, snapshot.data.documents);
////      },
////    );
////  }
////
////  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
////    return ListView(
////      padding: const EdgeInsets.only(top: 20.0),
////      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
////    );
////  }
////
////  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
////    final record = Record.fromSnapshot(data);
////
////    return Padding(
////      key: ValueKey(record.name),
////      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
////      child: Container(
////        decoration: BoxDecoration(
////          border: Border.all(color: Colors.grey),
////          borderRadius: BorderRadius.circular(5.0),
////        ),
////        child: ListTile(
////          title: Text(record.name),
////          trailing: Text(record.role.toString()),
////          onTap: () => record.reference.updateData({'votes': record.role}),
////        ),
////      ),
////    );
////  }
////}
////
////class Record {
////  final String name;
////  final String role;
////  final DocumentReference reference;
////
////  Record.fromMap(Map<String, dynamic> map, {this.reference})
////      : assert(map['name'] != null),
////        assert(map['role'] != null),
////        name = map['name'],
////        role = map['role'];
////
////  Record.fromSnapshot(DocumentSnapshot snapshot)
////      : this.fromMap(snapshot.data, reference: snapshot.reference);
////
////  @override
////  String toString() => "Record<$name:$role>";
////}