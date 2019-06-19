//
//import 'package:flutter/material.dart';
//import 'package:qr_flutter/qr_flutter.dart';
//import 'dart:ui';
//import 'package:flutter/rendering.dart';
//
//class NextPage extends StatefulWidget {
//  final String value;
//
//  NextPage({Key key, this.value}) : super(key: key);
//
//  @override
//  _NextPageState createState() => new _NextPageState();
//}
//
//class _NextPageState extends State<NextPage> {
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("Next Page"),
//      ),
//      body: new  Container(
//      color: const Color(0xFFFFFFFF),
//    child:
//    Expanded(
//    child:  Center(
//    child: RepaintBoundary(
//
//    child: QrImage(
//    data: widget.value,
//    onError: (ex) {
//    print("[QR] ERROR - $ex");
//
//
//
//    },
//    ),
//    ),
//    ),
//    ),
//
//    ));} }