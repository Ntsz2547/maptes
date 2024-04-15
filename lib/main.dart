import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:maptes/src/views/fullscreenmap.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map Test'),
        ),
        body: Center(
          child: FullScreenMap(),
        ),
      ),
    );
  }
}

