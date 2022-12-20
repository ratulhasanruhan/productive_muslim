
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';


class QiblaPage extends StatefulWidget {
  const QiblaPage({Key? key}) : super(key: key);

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {

  final _compassSvg = SvgPicture.asset('assets/compass.svg');
  final _needleSvg = SvgPicture.asset(
    'assets/needle.svg',
    fit: BoxFit.contain,
    height: 300,
    alignment: Alignment.center,
  );


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
        child:   SmoothCompass(
          //higher the value of rotation speed slower the rotation
          rotationSpeed: 170,
          height: 250.h,
          width: 250.h,
          compassAsset: Container(
            height: 280.h,
            width: 280.h,
            decoration:BoxDecoration(
                shape:BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _compassSvg,
                Transform.rotate(
                    child: _needleSvg,
                  angle: -pi / 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
