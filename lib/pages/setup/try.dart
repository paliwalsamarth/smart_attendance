//import 'package:firebase_auth/firebase_auth.dart';
//
//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import '../screens/Home/student.dart';
//import '../screens/Home/teacher.dart';
//import '../screens/Home/admin.dart';
//
//class LoginPage extends StatefulWidget {
//  @override
//  _LoginPageState createState() => new _LoginPageState();
//}
//
//class _LoginPageState extends State<LoginPage> {
//
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  String _email, _password;
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(),
//      body: Form(
//          key: _formKey,
//          child: Column(
//            children: <Widget>[
//              TextFormField(
//                validator: (input) {
//                  if(input.isEmpty){
//                    return 'Provide an email';
//                  }
//                },
//                decoration: InputDecoration(
//                    labelText: 'Email'
//                ),
//                onSaved: (input) => _email = input,
//              ),
//              TextFormField(
//                validator: (input) {
//                  if(input.length < 6){
//                    return 'Longer password please';
//                  }
//                },
//                decoration: InputDecoration(
//                    labelText: 'Password'
//                ),
//                onSaved: (input) => _password = input,
//                obscureText: true,
//              ),
//              RaisedButton(
//                onPressed: signIn,
//                child: Text('Sign in'),
//              ),
//            ],
//          )
//      ),
//    );
//  }
//
//  void signIn() async {
//    if(_formKey.currentState.validate()){
//      _formKey.currentState.save();
//      try{ FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
//
//
//
//      try{
//        StreamBuilder<DocumentSnapshot>(
//
//          stream: Firestore.instance
//              .collection('users')
//              .document(user.uid)
//              .snapshots(),
//          builder:
//              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//            if (snapshot.hasError) {
//              return Text('Error: ${snapshot.error}');
//            } else if (snapshot.hasData)
//            {
//              if (snapshot.data == null) {
//                debugPrint("No data");
//              }
//              if (snapshot.data['role'] == 'admin') {
//                debugPrint("Admin");
//                Navigator.push(context, MaterialPageRoute(
//                  builder: (context) => Admin(),
//
//                ));
//              } else if (snapshot.data['role'] == 'teacher') {
//                debugPrint("Teacher");
//                Navigator.push(context, MaterialPageRoute(
//                  builder: (context) => Teacher(),
//                ));
//              } else if (snapshot.data['role'] == 'student') {
//                debugPrint("Student");
//                Navigator.push(context, MaterialPageRoute(
//                  builder: (context) => Student(),
//                ));
//              }
//              else {
//                debugPrint("No data");
//              }
//            }
//
//
//          },
//        );
//      }catch(e){
//        print(e.message);
//      }
//
//
//
//      }catch(e){
//        print(e.message);
//      }
//    }
//  }}
