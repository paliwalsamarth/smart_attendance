//import 'dart:async';
//import 'package:smart_attendance/pages/screens/student/present.dart' as present;
//import 'package:barcode_scan/barcode_scan.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//
//
//
//
//Future scan() async {
//  try {
//    String barcode = await BarcodeScanner.scan();
//    setState(() => this.barcode = barcode);
//    present.updating(barcode);
//  } on PlatformException catch (e) {
//    if (e.code == BarcodeScanner.CameraAccessDenied) {
//      setState(() {
//        this.barcode = 'The user did not grant the camera permission!';
//      });
//    } else {
//      setState(() => this.barcode = 'Unknown error: $e');
//    }
//  } on FormatException{
//    setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
//  } catch (e) {
//    setState(() => this.barcode = 'Unknown error: $e');
//  }
//}