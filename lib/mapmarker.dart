import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class FlutterMaptest extends StatefulWidget {
  @override
  _FlutterMaptestState createState() => _FlutterMaptestState();
}

class _FlutterMaptestState extends State<FlutterMaptest>{

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

  Future<void> loadMarkers() async{
    String jsonString = await rootBundle.loadString('assets/json/markerdata.json');
    List<dynamic> rawMarkers = jsonDecode(jsonString);
    allMarkers = rawMarkers.map((markerJson) => Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(markerJson['lat'] as double, markerJson['lng'] as double), child: Column(
        children: [
          Icon(Icons.location_on, size: 45.0, color: Colors.red),
          Text(markerJson['Name'])
        ],
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