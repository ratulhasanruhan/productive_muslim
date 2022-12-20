import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class PrayerPage extends StatefulWidget {
  const PrayerPage({Key? key}) : super(key: key);

  @override
  _PrayerPageState createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  String mainValue = box.get('madhab', defaultValue: 'Hanafi');
  List salat = ['Fajr', 'Sunrise', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
  List icon_salat = [
    'assets/fajr.png',
    'assets/sunrise.png',
    'assets/sun.png',
    'assets/sun.png',
    'assets/evening.png',
    'assets/night.png',
  ];
  List<bool> alarmActive = [false, false, false, false, false, false];
  static var box = Hive.box('home');

  @override
  Widget build(BuildContext context) {

    bool hanafi(){
      if(box.get('madhab') == 'Shafi'){
        return false;
      }
      return true;
    }

    Coordinates coordinates = Coordinates(box.get('latitude',defaultValue: 24.4769288), box.get('longitude',defaultValue:  90.2934413));

    final params = CalculationMethod.karachi.getParameters();
    hanafi() ? params.madhab = Madhab.hanafi : params.madhab = Madhab.shafi;
    params.withMethodAdjustments(PrayerAdjustments(fajr: 1));
    final prayerTimes = PrayerTimes.today(coordinates, params);
    List<DateTime> timeList = [
      prayerTimes.fajr,
      prayerTimes.sunrise,
      prayerTimes.dhuhr,
      prayerTimes.asr,
      prayerTimes.maghrib,
      prayerTimes.isha,
    ];
    var nextPrayer = prayerTimes.nextPrayer();
    var nextPrayerTime = prayerTimes.timeForPrayer(nextPrayer);
    var diffence = DateTime.now().difference(nextPrayerTime!) + Duration(minutes: 2);
    var dhours = diffence.inHours.toString().replaceAll('-', '');
    var dMinute = diffence.inMinutes.remainder(60).toString().replaceAll('-', '');
    var crendTime = DateFormat.jm().format(nextPrayerTime.subtract(Duration(minutes: 5)));

    String noneFajr(){
      if(prayerTimes.currentPrayer().name == 'none'){
        return 'Isha';
      }
      return '${toBeginningOfSentenceCase(prayerTimes.currentPrayer().name)}';
    }

    bool tileb(String name){
      if(prayerTimes.currentPrayer().name == name){
        return true;
      }
      print('${prayerTimes.currentPrayer().name}');
      return false;
    }

    List<Color> tilecolor = [
      tileb('fajr') ? primaryColor :Colors.white,
      tileb('sunrise') ? primaryColor :Colors.white,
      tileb('dhuhr') ? primaryColor :Colors.white,
      tileb('asr') ? primaryColor :Colors.white,
      tileb('maghrib')? primaryColor :Colors.white,
      tileb('isha') ? primaryColor :Colors.white,
    ];

    List<Color> textilecolor = [
      tileb('fajr') ?Colors.white : Colors.black,
      tileb('sunrise') ?Colors.white : Colors.black,
      tileb('dhuhr') ?Colors.white : Colors.black,
      tileb('asr') ?Colors.white : Colors.black,
      tileb('maghrib')?Colors.white : Colors.black,
      tileb('isha') ?Colors.white : Colors.black,
    ];



    //TODO:  SAlat end TIme and TIle color

    Timer.periodic(Duration(seconds: 30), (t){
       setState(() {});
    });

    settingDialog(){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: waterColor,
              alignment: Alignment.center,
              title: const Text(
                'Salat Settings',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: darkColor, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              content: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton(
                            hint: Text('Madhab'),
                            value: mainValue,
                            items: [
                              DropdownMenuItem(
                                child: Text('Hanafi'),
                                value: 'Hanafi',
                              ),
                              DropdownMenuItem(
                                child: Text('Shafi, Maliki, Hanbli'),
                                value: 'Shafi',
                              ),
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                mainValue = value!;
                              });
                            }),
                      ],
                    );
                  }
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                TextButton(
                  child: Text('Update'),
                  onPressed: () {
                    box.put('madhab', mainValue);
                    Navigator.pop(context);
                    setState(() {});
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Salat Timing',
          style: TextStyle(color: darkColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: settingDialog,
              icon: Icon(
                Icons.settings,
                color: darkColor,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Container(
                width: double.infinity,
               // height: 95.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    gradient: const LinearGradient(colors: [
                      Color(0xFF0bab64),
                      Color(0xFF3bb78f),
                    ]),
                    boxShadow: [
                      BoxShadow(
                          color: deepColor, offset: Offset(0, 2), blurRadius: 3)
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/salat_back.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Color(0xFF3bb78f).withOpacity(0.1),
                          BlendMode.modulate),
                    )),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: IntrinsicHeight(
                    child: Row( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${noneFajr()} end time:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  crendTime,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sofia Bold',
                                    fontSize: 28,
                                  ),
                                ),
                                Text(
                                  'Current Prayer ${noneFajr()}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Sofia Bold',
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),

                        VerticalDivider(
                          color: backColor,
                          thickness: 1,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${noneFajr()} end after:',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: dhours,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Sofia Bold',
                                        fontSize: 28,
                                      ),
                                    ),
                                    TextSpan(
                                        text: 'h  ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )
                                    ),
                                    TextSpan(
                                      text: dMinute,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Sofia Bold',
                                        fontSize: 28,
                                      ),
                                    ),
                                    TextSpan(
                                        text: 'm',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )
                                    ),
                                  ]
                              ),
                            ),
                            Text(
                              'Next Prayer ${toBeginningOfSentenceCase(nextPrayer.name)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Sofia Bold',
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: salat.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 2),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 3,
                        shadowColor: waterColor,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                salat[index],
                                style: TextStyle(
                                  color: textilecolor[index],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(timeList[index]),
                                style: TextStyle(
                                  color: textilecolor[index],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          tileColor: tilecolor[index],
                          leading: Image.asset(
                            icon_salat[index],
                            width: 30.r,
                          ),
                          minLeadingWidth: 30.w,
                          trailing: IconButton(
                            onPressed: () {
                              if (alarmActive[index] == false) {
                                FlutterAlarmClock.createAlarm(
                                    timeList[index].hour,
                                    timeList[index].minute,
                                    title: salat[index]);
                              } else if (alarmActive[index] == true) {
                                FlutterAlarmClock.showAlarms();
                              }
                              setState(() {
                                alarmActive[index] = !alarmActive[index];
                              });
                            },
                            icon: Icon(
                              Icons.notifications_active,
                              color: alarmActive[index]
                                  ? Color(0xFFFFAD3C)
                                  : Color(0xFFE0E1E3),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
