import 'dart:async'; // ignore: unnecessary_import
import 'dart:core';
import 'dart:math';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/foundation.dart';




class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  final LatLngBounds SWUbounds = LatLngBounds(
    southwest: LatLng(13.744152201874209, 100.56355251503306),
    northeast: LatLng(13.746152201874209, 100.56555251503306),
  );
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(13.745152201874209, 100.56455251503306),
    zoom: 16.0,
    tilt: 70.0,
    bearing: 10.0,
  );

  MapboxMapController? mapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  Future<void> onMapClick(Point<double> point, LatLng latLng) async {
    if ((mapController?.cameraPosition?.tilt ?? 0) < 75.0) {
      mapController?.animateCamera(CameraUpdate.tiltTo(75));
    }
    List<dynamic> features =
        await mapController!.queryRenderedFeatures(point, [], null);
    if (features.isNotEmpty) {
      Map<String, dynamic> feature = features[0];
      if (feature['geometry']['type'] == 'Polygon') {
        var coordinates = feature['geometry']['coordinates'];
        List<List<LatLng>> geometry = coordinates
            .map((ll) =>
                ll.map((l) => LatLng(l[1], l[0])).toList().cast<LatLng>())
            .toList()
            .cast<List<LatLng>>();
      }
    }

    //onMapClick(point, latLng);

  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: _kInitialPosition,
      trackCameraPosition: true,
      styleString: 'mapbox://styles/noticszero/cluzqroj7005m01pk5dk0cx29',
      myLocationRenderMode: MyLocationRenderMode.GPS,
      onMapClick: onMapClick,
      zoomGesturesEnabled: true,
      
    );
  }

  void onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  
 
}


