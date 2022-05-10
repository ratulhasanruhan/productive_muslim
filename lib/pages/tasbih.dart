import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:just_audio/just_audio.dart';
import 'package:productive_muslim/constant.dart';
import 'dart:ui' as ui;


class Tasbih extends StatefulWidget {

  @override
  _TasbihState createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> {
  int count = 0;
  String tsEnglish = 'Subhanallah';
  String tsArabic = ' سبحان الله ';
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        centerTitle: true,
        title: Text('Tasbih',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Tasbih()));
              },
              icon: Icon(Icons.restart_alt)
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider('https://dm0qx8t0i9gc9.cloudfront.net/watermarks/image/rDtN98Qoishumwih/vector-arabic-calligraphy-translation-power-and-force-from-god_zyLKWAo__SB_PM.jpg'),
            alignment: Alignment.topRight,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1),
                  BlendMode.modulate),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Column(
              children: [
                Text( tsArabic,
                  style: TextStyle(
                    fontFamily: 'Qalam',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: darkColor
                  ),),
                Text( tsEnglish,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: darkColor
                  ),),
              ],
            ),

            NeumorphicText(count.toString(),
              textStyle: NeumorphicTextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sofia Bold'
              ),
              style: NeumorphicStyle(
                color: secondaryColor,
              ),
            ),

            NeumorphicButton(
              padding: EdgeInsets.all(30.r),
              style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  color: secondaryColor,
                  depth: 20,
                  shape: NeumorphicShape.convex),
              onPressed: () async{
                var duration = await player.setAsset('assets/tap.mp3');
                player.play();

                setState(() {
                  count++;
                  if(count == 33){
                    Vibrate.vibrate();
                    tsArabic = 'ٱلْحَمْدُ لِلَّٰهِ';
                    tsEnglish = 'Alhamdulillah';
                  }else if(count == 64){
                    Vibrate.vibrate();
                    tsArabic = 'الله أكبر';
                    tsEnglish = 'Allahu Akbar';
                  }else if(count == 100){
                    Vibrate.vibrate();
                     tsEnglish = 'Subhanallah';
                     tsArabic = ' سبحان الله ';
                     count = 0;
                  }
                });
              },
              child: NeumorphicText('Tap',
                  textStyle: NeumorphicTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                style: NeumorphicStyle(
                  color: Colors.white,
                ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
