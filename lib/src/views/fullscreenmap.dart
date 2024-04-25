import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

class mapshowpage extends StatefulWidget {
 @override
 _mapshowpageState createState() => _mapshowpageState();
}

class _mapshowpageState extends State<mapshowpage> {
 List<Marker> allMarkers = [];

 @override
 void initState() {
  // TODO: implement initState
  super.initState();
  loadMarkers();
 }

 @override
 void dispose() {
  super.dispose();
 }

 Future<void> loadMarkers() async {
  String jsonString =
    await rootBundle.loadString('assets/json/markerdata.json');
  List<dynamic> rawMarkers = jsonDecode(jsonString);
  allMarkers = rawMarkers
    .map((markerJson) => Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(
        markerJson['lat'] as double, markerJson['lng'] as double),
      child: GestureDetector(
       onTap: () {
        showDialog(
         context: context,
         builder: (BuildContext context) {
          return AlertDialog(
           title: Text('Marker Info'),
           content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text('Latitude: ${markerJson['lat']}'),
             Text('Longitude: ${markerJson['lng']}'),
             Text(
              'Building: ${markerJson['Building']}',
             ),
             Text('Name: ${markerJson['Name']}'),
            ],
           ),
           actions: [
            TextButton(
             child: Text('Close'),
             onPressed: () {
              Navigator.of(context).pop();
             },
            ),
           ],
          );
         },
        );
       },
       child: Column(
        children: [
         Icon(Icons.location_on, size: 45.0, color: Colors.green),
        ],
       ),
      )))
    .toList();
  setState(() {
   allMarkers = allMarkers;
  });
 }

 MapController? mapController;
 @override
 Widget build(BuildContext context) {
  return Scaffold(
   body: Stack(
    children: [
     FlutterMap(
      options: MapOptions(
       center: LatLng(13.745322833337358, 100.56528296835661),
       zoom: 17.0,
       minZoom: 17.0,
       maxZoom: 19.0,
       enableMultiFingerGestureRace: true,
       //disble interact
       interactiveFlags: InteractiveFlag.doubleTapDragZoom |
          InteractiveFlag.doubleTapZoom |
       InteractiveFlag.flingAnimation |
       InteractiveFlag.pinchZoom |
       InteractiveFlag.scrollWheelZoom,  
       rotation: -15.0, 
      ),
      children: [
       TileLayer(
        urlTemplate:
          'https://api.mapbox.com/styles/v1/noticszero/cluzqroj7005m01pk5dk0cx29/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoibm90aWNzemVybyIsImEiOiJjbHV6cW1udHAxZW9zMmtudzdzaTdpaGp0In0.biD8--EXRF9VUcLqY-9x5g',
        userAgentPackageName: 'https://studio.mapbox.com/',
       ),
       MarkerLayer(
        markers: allMarkers,
       ),
      ],
     ),
     Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AppBar(
       backgroundColor: Colors.white,
       title: TextField(
        decoration: InputDecoration(
         hintText: 'Search',
         hintStyle: TextStyle(color: Colors.white),
        ),
        style: TextStyle(color: Colors.white),
       ),
      ),
     ),
     Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
       height: 50,
       color: Colors.blue,
       child: Center(
        child: Text(
         'Bottom Bar',
         style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
         ),
        ),
       ),
      ),
     ),
    ],
   ),
  );
 
  }
}

