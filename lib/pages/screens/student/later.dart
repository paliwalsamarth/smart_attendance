import 'package:smart_attendance/pages/screens/Login/login.dart';

import 'package:flutter/material.dart';

class LaterPage extends StatefulWidget {
  @override
  _LaterPageState createState() => _LaterPageState();
}

class _LaterPageState extends State<LaterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To be continued.'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
         Center (
             child: Text('Left space for chat, group discussion etc'),
         ),

        ],
      ),
    );
  }

  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
  }

}