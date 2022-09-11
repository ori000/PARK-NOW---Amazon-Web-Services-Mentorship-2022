import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import"package:latlong2/latlong.dart" as LLatLong;
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

void main(){
  runApp(MaterialApp(
    title:"Test",
      home:Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<LLatLong.LatLng> markerz =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("My Map"),
        ),
      ),
      body: Stack(
        children: [FlutterMap(
            options: MapOptions(
                enableScrollWheel: true,
                scrollWheelVelocity: 0.005,
                center: LLatLong.LatLng(33.888,35.499),
                zoom: 12,
                maxBounds: LatLngBounds(
                    LLatLong.LatLng(33.5,35.4),LLatLong.LatLng(34,36)
                ) ,
                onTap: (TapPosition p,LLatLong.LatLng location){

                  //markers.add(location);

                  print(location);

                }
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://api.mapbox.com/styles/v1/hmk57/cl702agoy000915nvfg50xadd/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaG1rNTciLCJhIjoiY2w3MDI4N2c2MGE5NzNvb3kzZTUydTd4ZiJ9.yZKA4VnS1qdJqPAe3eiOKw",
                userAgentPackageName: 'com.example.app',
                additionalOptions:{
                  "accessToken":'pk.eyJ1IjoiaG1rNTciLCJhIjoiY2w3MDI4N2c2MGE5NzNvb3kzZTUydTd4ZiJ9.yZKA4VnS1qdJqPAe3eiOKw',
                  "id":"mapbox.mapbox-streets-v8" , //What will the map show
                },
              ),
              MarkerLayerOptions(
                //Creating Markers with children icon buttons
                // TO-DO: Implement the popup page when clicking the icon
                
                markers: [
                  Marker(
                      point: LLatLong.LatLng(33.818452, 35.705641),
                      builder: (BuildContext context){return IconButton(
                        onPressed: (){print("Yes Daddy");},
                        icon: Icon(
                          Icons.connecting_airports_sharp,
                        ),
                      );}
                  ),
                  Marker(
                      point: LLatLong.LatLng(33.885127, 35.48064),
                      builder: (BuildContext context){return IconButton(
                        onPressed: (){print("Yes Daddy 2");},
                        icon: Icon(
                          Icons.connecting_airports_sharp,
                        ),
                      );}
                  ),
                  Marker(
                      point: LLatLong.LatLng(33.892879, 35.478387),
                      builder: (BuildContext context){return IconButton(
                        onPressed: (){print("Yes Daddy 3");},
                        icon: Icon(
                          Icons.connecting_airports_sharp,
                        ),
                      );}
                  ),
                  Marker(
                      point: LLatLong.LatLng(33.900676, 35.481628),
                      builder: (BuildContext context){return IconButton(
                        onPressed: (){print("Yes Daddy 4");},
                        icon: Icon(
                          Icons.connecting_airports_sharp,
                        ),
                      );}
                  ),

                ],

              ),

            ]),
        Align(
          alignment: Alignment.topCenter,
          child:Container(
            width: 200,
            height: 25,
            margin: EdgeInsets.fromLTRB(200,20,200,20),
            child: TextField(
              cursorColor: Colors.white,
              //maxLines: 222,

              style: TextStyle(
                fontSize: 12,
                color: Colors.white ,
              ),
              decoration: InputDecoration(
                alignLabelWithHint: true,

                //Color of the textfield
                fillColor: Colors.blue,
                filled: true,

                border: OutlineInputBorder(),
                //labelText: 'Search Here',
                label: Center(
                  child: Text("Search Here"),
                ),
                labelStyle: TextStyle(
                  color: Colors.white ,

                ),
                contentPadding:  EdgeInsets.all(20),




                //hintText: 'Search Location',
              ),

            ),
          ) ,
        ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_a_photo_outlined,
            ),
            label: "Parkings Near Me",
            tooltip: "Click Me Daddy",

          ),
          BottomNavigationBarItem(

            icon: Icon(

              Icons.ac_unit_sharp,
            ),
            label: "Hot Deals",
            tooltip: "Click Me Daddy",

          )
        ],
      ),
    );

  }
}
