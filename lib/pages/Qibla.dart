import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/location_error.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({Key? key}) : super(key: key);

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  final _locationStreamController = StreamController<LocationStatus>.broadcast();
  get stream => _locationStreamController.stream;

  final _compassSvg = SvgPicture.asset('assets/compass.svg');
  final _needleSvg = SvgPicture.asset(
    'assets/needle.svg',
    fit: BoxFit.contain,
    height: 300,
    alignment: Alignment.center,
  );

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qibla'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: stream,
          builder: (context, AsyncSnapshot<LocationStatus> snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.data!.enabled == true) {
              switch (snapshot.data!.status) {
            case LocationPermission.always:
                case LocationPermission.whileInUse:
                  return  StreamBuilder(
                    stream: FlutterQiblah.qiblahStream,
                    builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return CircularProgressIndicator();

                      final qiblahDirection = snapshot.data!;

                      return Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Transform.rotate(
                            angle: (qiblahDirection.direction * (pi / 180) * -1),
                            child: _compassSvg,
                          ),
                          Transform.rotate(
                            angle: (qiblahDirection.qiblah * (pi / 180) * -1),
                            alignment: Alignment.center,
                            child: _needleSvg,
                          ),
                          Positioned(
                            bottom: 8,
                            child: Text("${qiblahDirection.offset.toStringAsFixed(3)}°"),
                          )
                        ],
                      );
                    },
                  );

                case LocationPermission.denied:
                  return LocationErrorWidget(
                    error: "Location service permission denied",
                    callback: _checkLocationStatus,
                  );
                case LocationPermission.deniedForever:
                  return LocationErrorWidget(
                    error: "Location service Denied Forever !",
                    callback: _checkLocationStatus,
                  );
                default:
                  return Container();
              }
            } else {
              return LocationErrorWidget(
                error: "Please enable Location service",
                callback: _checkLocationStatus,
              );
            }
          },
        ),
      ),
    );
  }
}
