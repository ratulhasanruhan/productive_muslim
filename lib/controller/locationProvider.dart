import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:productive_muslim/constant.dart';
import 'package:provider/provider.dart';

class LocationProvider extends ChangeNotifier {
  var address;
  var address2;

  var latitude;
  var longitude;

  static var box = Hive.box('home');


  Future getLocation(BuildContext context) async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Location permission required!'),
            content: Text('Please allow location permission'),
            actions: [
              TextButton(
                onPressed: () {
                  openAppSettings();
                },
                child: Text('Open Settings'),
              ),
            ],
          );
        },
      );
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest, forceAndroidLocationManager: true);
    await box.put('latitude', position.latitude);
    await box.put('longitude', position.longitude);

    latitude = position.latitude;
    longitude = position.longitude;
    notifyListeners();

    await Geocoder2.getDataFromCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
        googleMapApiKey: googleAPIkey).then((value) {

      address = value.address.split(" ").elementAt(0);
      address2 = value.city.toString();
      notifyListeners();


      return address;
    });


  }
}
