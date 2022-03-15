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

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    await box.put('latitude', position.latitude);
    await box.put('longitude', position.longitude);

    latitude = position.latitude;
    longitude = position.longitude;
    notifyListeners();

    FetchGeocoder fetchGeocoder = await Geocoder2.getAddressFromCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
        googleMapApiKey: googleAPIkey);

    String data = fetchGeocoder.results.first.formattedAddress;
    address = data.split(" ").elementAt(1).replaceAll(',', '');
    address2 = data.split(" ").elementAt(2).replaceAll(',', '');

    notifyListeners();
  }
}
