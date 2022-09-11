import "package:flutter/material.dart";
import 'package:flutter_login_ui/pages/deals.dart';
import 'package:flutter_login_ui/pages/login_page.dart';
import 'package:flutter_login_ui/pages/near_me.dart';
import 'package:flutter_login_ui/pages/view_all.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import "package:latlong2/latlong.dart" as LLatLong;
import 'popUpWindow.dart';
void main(){
  runApp(Home());
}


//marker class, needs to be given custom info as parameter from the database
class CustomMarker extends Marker{
  //It takes the same parameters as the marker in addition to a map (key is the domain (Name,email,price,...) and the values are the
  //values of the domains
  Map<String, String> info;


  CustomMarker({   required LLatLong.LatLng point,   required Widget Function(BuildContext) builder,   Key? key,
    double width = 30.0,   double height = 30.0,   bool? rotate,   Offset? rotateOrigin,
    AlignmentGeometry? rotateAlignment,   AnchorPos ? anchorPos,  required  Map<String,String> this.info })
      :super(point:point,
      builder:builder,
      key:key,
      width:width,
      height:height,
      rotate:rotate,
      rotateOrigin:rotateOrigin,
      rotateAlignment:rotateAlignment,
      anchorPos:anchorPos);

}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class MapPage extends StatefulWidget {
  MapPage({ Key? key }) : super(key: key);
  Color markerDefaultColor=Colors.black;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Widget> widgetz=[];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[FlutterMap(
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
              // urlTemplate:"https://api.mapbox.com/geocoding/v5/mapbox.places/-73.9880157040927,40.75746949615191.json?limit=1&types=place%2Cpostcode%2Caddress&access_token=YOUR_MAPBOX_ACCESS_TOKEN",
              userAgentPackageName: 'com.example.app',
              additionalOptions:{
                "accessToken":'pk.eyJ1IjoiaG1rNTciLCJhIjoiY2w3MDI4N2c2MGE5NzNvb3kzZTUydTd4ZiJ9.yZKA4VnS1qdJqPAe3eiOKw',
                "id":"mapbox.mapbox-streets-v8" , //What will the map show
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                    point: LLatLong.LatLng(33.818452, 35.705641),
                    builder: (BuildContext context){return IconButton(
                      color: widget.markerDefaultColor,
                      onPressed: (){
                        setState(() {
                          widget.markerDefaultColor=Colors.blue;
                        });
                        print("Yes Daddy");
                        Map<String,String> info={'Name':'AUBMC ','Phone':'78999301','Area':'Hamra','Price':'20 \$'};

                        Navigator.of(context).push(
                        DialogRoute(
                            context: context,

                            builder: (context) => PopUp(
                                info:info,
                            ))
                        ).whenComplete(() {
                          setState(() {
                            widget.markerDefaultColor=Colors.black;

                          });
                        });


                        //widgetz.add(PopUp());

                      },
                      icon: Icon(
                        Icons.connecting_airports_sharp,
                      ),
                    );}
                ),
                Marker(
                    point: LLatLong.LatLng(33.885127, 35.48064),
                    builder: (BuildContext context){return IconButton(
                      onPressed: (){print("Yes Daddy 2");
                        //widgetz.add(PopUp());
                      setState(() {

                      });},
                      icon: Icon(
                        Icons.connecting_airports_sharp,
                      ),
                    );}
                ),
                Marker(
                    point: LLatLong.LatLng(33.892879, 35.478387),
                    builder: (BuildContext context){return IconButton(
                      onPressed: (){
                        print("Yes Daddy 3");
                       // widgetz.add(PopUp());
                        setState(() {

                        });},
                      icon: Icon(
                        Icons.connecting_airports_sharp,
                      ),
                    );}
                ),
                Marker(
                    point: LLatLong.LatLng(33.900676, 35.481628),
                    builder: (BuildContext context){return IconButton(
                      onPressed: (){
                        print("Yes Daddy 4");
                        //widgetz.add(PopUp());
                        setState(() {

                        });
                        },
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

      ] +widgetz,
    ); //Center
  }
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    final screens=[
      MapPage(), ViewAllPage(), DealsPage(), NearMePage()
    ];

    return MaterialApp(
      title:"Okay",
      home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Go to Login Page!'),
              ),
          ),
        ) ,
         body: screens[_selectedIndex],


        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,

          selectedItemColor: Colors.red,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'View All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Deals',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Near Me',
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
      ),
    );

  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
