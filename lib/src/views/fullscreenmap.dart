import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:maptes/src/views/maplistview.dart';
import 'package:url_launcher/url_launcher.dart';

class mapshowpage extends StatefulWidget {
  @override
  _mapshowpageState createState() => _mapshowpageState();
}

class _mapshowpageState extends State<mapshowpage> {
  List<Marker> allMarkers = [];
  List<Marker> displayedMarkers = [];
  String searchQuery = '';

  TextEditingController searchController = TextEditingController();

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
                    return Dialog(
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        width: 500, // Set the width
                        height: 400, // Set the height
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                              height: 15,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 50.0),
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Marker Info",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                            Expanded(
                                child: Container(
                              height: 5,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 0.0),
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: markerJson['Building'] == "-"
                                    ? [
                                        Text('${markerJson['Name']}'),
                                        Text('${markerJson['Description']}')
                                      ]
                                    : [
                                        Text('${markerJson['Name']}'),
                                        Text('อาคาร ${markerJson['Building']}'),
                                      ],
                              ),
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                            Expanded(
                                child: Container(
                              height: 10,
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: 20.0, vertical: 20.0),
                              alignment: Alignment.topCenter,
                              child: ElevatedButton(
                                onPressed: () {
                                  _launchURL(markerJson['Link']);
                                },
                                child: Text('Open Link'),
                              ),
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Column(
                children: [
                  Icon(Icons.location_on,
                      size: 45.0, color: Color.fromRGBO(218, 33, 40, 1.0)),
                ],
              ),
            )))
        .toList();
    setState(() {
      allMarkers = allMarkers;
    });
  }

  void updateDisplayedMarkers() {
    setState(() {
      displayedMarkers = allMarkers
          .where((marker) => marker.child.toString().contains(searchQuery))
          .toList();
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void searchMarker() {
    String query = searchController.text;
    Marker? foundMarker = allMarkers.firstWhere(
      (marker) => marker.child.toString().contains(query),
      orElse: () => Marker(
        width: 0.0,
        height: 0.0,
        point: LatLng(0.0, 0.0),
        child: Container(),
      ),
    );

    if (foundMarker != null) {
      print('Found marker: ${foundMarker.point}');
      mapController?.move(foundMarker.point, 18.0);
    }
  }

  MapController? mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListviewBtn()));
            },
          ),
        ],
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
              updateDisplayedMarkers();
            });
          },
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey[400]),
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
      ),
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
        ],
      ),
    );
  }
}
