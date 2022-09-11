import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'popupWindow.dart';
import"package:latlong2/latlong.dart" as LLatLong;
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class CustomMarker extends Marker{
  //It takes the same parameters as the marker in addition to a map (key is the domain (Name,email,price,...) and the values are the
  //values of the domains
  Map<String, String> info;


  CustomMarker({   required LLatLong.LatLng point,      Key? key,
    double width = 30.0,   double height = 30.0,   bool? rotate,   Offset? rotateOrigin,
    AlignmentGeometry? rotateAlignment,   AnchorPos ? anchorPos,  required  Map<String,String> this.info })
      :super(point:point,
      builder:(BuildContext context){
        return IconButton(
            icon: Icon(Icons.account_balance_wallet),

            onPressed: (){
              print("Yes Daddy");


            });

      },
      key:key,
      width:width,
      height:height,
      rotate:rotate,
      rotateOrigin:rotateOrigin,
      rotateAlignment:rotateAlignment,
      anchorPos:anchorPos);

}
