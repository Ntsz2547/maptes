//add spladh screen 
import 'package:flutter/material.dart';
import 'package:maptes/src/views/unimodel.dart';
import 'package:maptes/src/views/fullscreenmap.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LayerMap(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Image.asset('assets/splash/mapsplash.png'),
      ),
    );
  }
}