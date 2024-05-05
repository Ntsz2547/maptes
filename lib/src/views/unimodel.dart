import 'package:flutter/material.dart';
import 'package:maptes/src/views/fullscreenmap.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class LayerMap extends StatefulWidget {
  @override
  _LayerMapState createState() => _LayerMapState();
}

class _LayerMapState extends State<LayerMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                  )),
                ))
              ],
            ),
          ),
          Container(
            height: 400,
            child: ModelViewer(
              src: 'assets/maptest.glb',
              alt: "MAPMOR",
              cameraControls: true,
              autoRotate: true,
              disableZoom: false,
              // Disable camera controls
            ),
          ),
          Container(
            height: 55.0,
            width: 200.0,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10.0),
            //   color: Color.fromRGBO(218, 33, 40, 1.0),
            // ),
            margin: EdgeInsets.symmetric(horizontal: 50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => mapshowpage(),
                  ),
                );
              },
              child: Text('Get Started'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(218, 33, 40, 1.0),
                ), // Change the color here
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
