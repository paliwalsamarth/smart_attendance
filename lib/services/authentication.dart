import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


class UserData {// here users are made , we need to give it another variable , i.e. role - teacher or student
  String displayName;
  String email;
  String uid;
  String password;

  UserData({this.displayName, this.email, this.uid, this.password});
}

class UserAuth {
  String statusMsg="Account Created Successfully";
  //To create new User
  Future<String> createUser(UserData userData) async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: userData.email, password: userData.password);
    return statusMsg;
  }

  //To verify new User
  Future<String> verifyUser (UserData userData) async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: userData.email, password: userData.password);
    return "Login Successfull";
  }
}
