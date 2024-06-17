import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class location {

    late  double latitude;
    late  double longitude;

   Future <void> getCurrentlocation() async {
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best);
         latitude = position.latitude;
          longitude = position.longitude;
        } catch(e){
          print(e);
        }
        LocationPermission permission = await Geolocator.requestPermission();
        print(permission);
      }

    }



