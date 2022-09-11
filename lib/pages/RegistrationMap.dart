import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as LLatLong;
import 'CustomMarkers.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'registration_page_collab.dart';


class RegistrationMap extends StatefulWidget {
  RegistrationMap({Key? key}) : super(key: key);
  List<CustomMarker> markerz =[]; //Marker of the place
  Map<String,double> pointz={"longitude":-1,"latitude":-1};//Storing the longitude and the latitude of the confirmed location

  bool confirmed=false;

  @override
  State<RegistrationMap> createState() => _RegistrationMapState();
}

class _RegistrationMapState extends State<RegistrationMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options:MapOptions(
            enableScrollWheel: true,
            scrollWheelVelocity: 0.005,
            center: LLatLong.LatLng(33.888,35.499),
            zoom: 12,
            maxBounds: LatLngBounds(
                LLatLong.LatLng(33.5,35.4),LLatLong.LatLng(34,36)
            ) ,
            onTap: (TapPosition p,LLatLong.LatLng location){
              //widget.markerz.add(CustomMarker(point: location, info: {}));
              setState(() {
                widget.markerz=<CustomMarker>[CustomMarker(point: location, info:{})];

              });
              Navigator.of(context).push(
                  DialogRoute(
                      context: context,
                      builder:
                          (BuildContext context){
                        return Dialog(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 100,
                            height: 80,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Center(child:Text("Confirm Location")),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: (){
                                          //To-Do:Store the latitude and longitude and move into other page
                                          // Add here the variable

                                          // store longtitude and latitude
                                          widget.pointz['longitude']=widget.markerz[0].point.longitude;
                                          widget.pointz['latitude']=widget.markerz[0].point.latitude;
                                          print("Confirmed");
                                          RegistrationPageCollab.txt_longitude.text="${widget.pointz['longitude']}";
                                          RegistrationPageCollab.txt_latitude.text="${widget.pointz['latitude']}";




                                          widget.confirmed=true;// Handles the case when the user clicks outside the dialogue
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          //To-Do exit the page
                                        },
                                        child: Text("Confirm")),
                                    TextButton(
                                        onPressed: (){
                                          //Stay on the same page
                                          print("Canceled");
                                          Navigator.of(context).pop();
                                          setState(() {
                                            widget.markerz=<CustomMarker>[];
                                          });
                                        },
                                        child: Text("Cancel")),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  )
              ).whenComplete(
                      (){

                    //Navigator.of(context).pop();
                    setState(() {
                      if (!widget.confirmed){
                        print("Canceled");
                        widget.markerz=<CustomMarker>[];
                      }
                    });
                    widget.confirmed=false;
                  }
              );



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
            markers: widget.markerz,
          )]


    );
  }
}