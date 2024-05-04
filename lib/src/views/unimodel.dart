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
      appBar: AppBar(
        title: Text('Maptes'),
      ),
      body: Container(
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 10.0,
              maxScale: 20.0,
              child: ModelViewer(
                src: 'assets/maptest.glb',
                alt: "MAPMOR",
                cameraControls: true,
                autoRotate: true,
                disableZoom: false,
                // Disable camera controls
              ),
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: ElevatedButton(
                onPressed: () {
                    Navigator.of(context).push(
                     MaterialPageRoute(
                  builder: (context) => mapshowpage(),
                    ),
  );
                },
                child: Text('Button'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
