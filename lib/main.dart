import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:maptes/src/views/fullscreenmap.dart';
import 'package:maptes/src/views/maplistview.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Map Test',
      home: Scaffold(
        body: Center(
          child: mapshowpage(),
        ),
      ),
    );
  }
}
