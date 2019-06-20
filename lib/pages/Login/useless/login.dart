//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:smart_attendance/pages/home.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:smart_attendance/theme/style.dart';
//import 'style.dart';
//import 'package:smart_attendance/components/TextFields/inputField.dart';
//import 'package:smart_attendance/components/Buttons/textButton.dart';
//import 'package:smart_attendance/components/Buttons/roundedButton.dart';
//import 'package:smart_attendance/services/validations.dart';
//
//class LoginPage extends StatefulWidget {
//  @override
//  _LoginPageState createState() => new _LoginPageState();
//}
//
//class _LoginPageState extends State<LoginPage> {
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  String _email, _password;
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
////  void showInSnackBar(String value) {
////    _scaffoldKey.currentState
////        .showSnackBar(new SnackBar(content: new Text(value)));
////  }
//
//  bool autovalidate = false;
//  Validations validations = new Validations();
//
//
//  @override
//  Widget build(BuildContext context) {
//    final Size screenSize = MediaQuery.of(context).size;
//    return new Scaffold(
//      appBar: new AppBar(),
//      body: Form(
//          key: _formKey,
//          child: Column(
//            children: <Widget>[
//              new InputField(
//                  hintText: "Email",
//                  obscureText: false,
//                  textInputType: TextInputType.text,
//                  textStyle: textStyle,
//                  textFieldColor: textFieldColor,
//                  icon: Icons.mail_outline,
//                  iconColor: Colors.black,
//                  bottomMargin: 20.0,
//                  validateFunction: validations.validateEmail,
//                onSaved: (input) => _email = input,
//                  ),
//              new InputField(
//                  hintText: "Password",
//                  obscureText: true,
//                  textInputType: TextInputType.text,
//                  textStyle: textStyle,
//                  textFieldColor: textFieldColor,
//                  icon: Icons.lock_open,
//                  iconColor: Colors.black,
//                  bottomMargin: 30.0,
//                  validateFunction:
//                  validations.validatePassword,
//                onSaved: (input) => _password = input,),
//
////              TextFormField(
//////                validator: (input) {
//////                  if (input.isEmpty) {
//////                    return 'Provide an email';
//////                  }
//////                },
////                decoration: InputDecoration(labelText: 'Email'),
////
////                onSaved: (input) => _email = input,
////              ),
//
//              new RoundedButton(
//                buttonName: "Get Started",
//                onTap: signIn,
//                width: screenSize.width,
//                height: 50.0,
//                bottomMargin: 10.0,
//                borderWidth: 0.0,
//                buttonColor: primaryColor,
//              ),
//            ],
//          )),
//    );
//  }
//
//  void signIn() async {
//    if (_formKey.currentState.validate()) {
//      _formKey.currentState.save();
//      try {
//        FirebaseUser user = await FirebaseAuth.instance
//            .signInWithEmailAndPassword(email: _email, password: _password);
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => Home(user: user)));
//      } catch (e) {
//        print(e.message);
////        showInSnackBar(e.message.toString());
//      }
//    }
//  }
//}
