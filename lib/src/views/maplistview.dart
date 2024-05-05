import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ListviewBtn extends StatefulWidget {
  const ListviewBtn({Key? key}) : super(key: key);

  @override
  State<ListviewBtn> createState() => _ListviewBtnState();
}

class _ListviewBtnState extends State<ListviewBtn> {
  late Future<List<dynamic>> _futureBdata; // Future for Building data

  @override
  void initState() {
    super.initState();
    _futureBdata = loadData();
  }

  Future<List<dynamic>> loadData() async {
    String jsonString =
        await rootBundle.loadString('assets/json/markerdata.json');
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF636466),
      appBar: AppBar(
        title: Text(
          "Buildings Informations",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFDA2128),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureBdata,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic>? Bdata = snapshot.data;
            return ListView.builder(
              itemCount: Bdata!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  child: ListTile(
                    title: Text(Bdata[index]['Name'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("อาคาร: ${Bdata[index]['Building']}"),
                    leading: Icon(
                      Icons.business,
                      color: Color(0xFFDA2128),
                    ),
                    trailing: Icon(
                      Icons.keyboard_double_arrow_right_rounded,
                      color: Color(0xFF636466),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => ListDetails(
                              buildings: Bdata,
                              index: index,
                            )),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ListDetails extends StatelessWidget {
  final List<dynamic> buildings;
  final int index;

  const ListDetails({
    Key? key,
    required this.buildings,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> building = buildings[index];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Building Informations",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFDA2128),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${building['Name']}",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              "Building: ${building['Building']}",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              "Latitude: ${building['lat']}",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              "Longtitude: ${building['lng']}",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
