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

class _mapshowpageState extends State<mapshowpage>{

  List<Marker> allMarkers = [];
  MapController mapController = MapController();

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
    String jsonString = await rootBundle.loadString('assets/json/markerdata.json');
    List<dynamic> rawMarkers = jsonDecode(jsonString);
    allMarkers = rawMarkers.map((markerJson) => Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(markerJson['lat'] as double, markerJson['lng'] as double), 
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
                    Text('Name: ${markerJson['name']}'),
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
            Icon(Icons.location_on, size: 45.0, color: Colors.red),
          ],
        ),
      )
    )).toList();
    setState(() {
      allMarkers = allMarkers;
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(13.745152201874209, 100.56455251503306),
              zoom: 17.2,
             // swPanBoundary: LatLng(13.744152201874209, 100.56355251503306),
             // nePanBoundary: LatLng(13.746152201874209, 100.56555251503306
            ),
            children: [
              TileLayer(
                  urlTemplate: 'https://api.mapbox.com/styles/v1/noticszero/cluzqroj7005m01pk5dk0cx29/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoibm90aWNzemVybyIsImEiOiJjbHV6cW1udHAxZW9zMmtudzdzaTdpaGp0In0.biD8--EXRF9VUcLqY-9x5g',
                  userAgentPackageName: 'https://studio.mapbox.com/',
              ),  
                MarkerLayer(
                markers: allMarkers
              ),
            ],
            
          ),
        ],
      ),
    );
  }


}