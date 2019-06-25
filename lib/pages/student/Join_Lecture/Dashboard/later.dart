//import 'package:smart_attendance/pages/screens/Login/useless/login.dart';

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
        automaticallyImplyLeading: false,
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


}