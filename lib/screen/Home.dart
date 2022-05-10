import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:productive_muslim/constant.dart';
import 'package:productive_muslim/controller/locationProvider.dart';
import 'package:productive_muslim/pages/Fatwa.dart';
import 'package:productive_muslim/pages/Qibla.dart';
import 'package:productive_muslim/pages/Settings.dart';
import 'package:productive_muslim/pages/Videos.dart';
import 'package:productive_muslim/pages/Zakat.dart';
import 'package:productive_muslim/pages/allah_names.dart';
import 'package:productive_muslim/pages/blog.dart';
import 'package:productive_muslim/pages/hadith.dart';
import 'package:productive_muslim/pages/tasbih.dart';
import 'package:productive_muslim/widgets/CategoryIcon.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as native;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../pages/Books.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static var box = Hive.box('home');
  var hijri = HijriCalendar.now();
  String formatDate = DateFormat('EEEE, dd MMMM').format(DateTime.now());
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('home');
  var data;

  final YoutubePlayerController web_controller = YoutubePlayerController(
    initialVideoId: box.get('video', defaultValue: '2URsyhCCKw0'),
    params: const YoutubePlayerParams(
      showVideoAnnotations: false,
      showControls: true,
      showFullscreenButton: true,
      strictRelatedVideos: true,
    ),
  );

  native.YoutubePlayerController native_controller = native.YoutubePlayerController (
    initialVideoId: box.get('video', defaultValue: '2URsyhCCKw0'),
    flags: const native.YoutubePlayerFlags(
      autoPlay: false,
    )
  );

  Future latestData() async {
    setState(() async {
      await collectionReference.doc('latest').get().then((value) {
        data = value;

         box.put('image', value['image_link']);
         box.put('content', value['content']);
         box.put('video', value['video_id']);
         box.put("is_image", value['is_image']);
      });
    });

  }

  @override
  void initState() {
    super.initState();
    latestData();
    //TODO:
    Timer(const Duration(seconds: 3), (){
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    web_controller.close();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final location = Provider.of<LocationProvider>(context);

    Coordinates webCor(){
      if(location.latitude == null){
          return Coordinates(24.4769288, 90.2934413);
      }
      return Coordinates(location.latitude, location.longitude);
    }
    Coordinates coordinates = webCor();

    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    params.adjustments.fajr = -6;
    params.adjustments.maghrib = 3;
    final prayerTimes = PrayerTimes.today(coordinates, params);

    return ScreenUtilInit(
      builder: () {
        return Scaffold(
          backgroundColor: backColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: size.height / 3.5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.elliptical(100, 50),
                                bottomRight: Radius.elliptical(100, 50)),
                            color: secondaryColor,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: const AssetImage(
                                    'assets/mosque_background.jpg'),
                                colorFilter: ColorFilter.mode(
                                    secondaryColor.withOpacity(0.2),
                                    BlendMode.modulate)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 35.h, left: 20.w, right: 5.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Assalamualaikum,',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Sofia Bold',
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    const Text(
                                      'Let\'s start',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Sofia',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Blog()));
                                  },
                                  icon: const FaIcon(FontAwesomeIcons.bookOpen),
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                        )
                      ],
                    ),

                    //Timing Card
                    Container(
                      //height: 150.h,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(right: 15.w, left: 15.w),
                      child: Card(
                        color: Colors.white,
                        elevation: 8,
                        shadowColor: primaryColor.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(22.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: DateFormat('hh:mm').format(prayerTimes.fajr),
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                width: 3,
                                              )),
                                              TextSpan(
                                                text: DateFormat('a').format(prayerTimes.fajr),
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        const Text(
                                          'Sehri Last Time',
                                          style: TextStyle(
                                              color: deepColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    const VerticalDivider(
                                      color: deepColor,
                                      thickness: 0.8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: DateFormat('hh:mm').format(prayerTimes.maghrib),
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                width: 3,
                                              )),
                                              TextSpan(
                                                text: DateFormat('a').format(prayerTimes.maghrib),
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        const Text(
                                          'Iftar Time',
                                          style: TextStyle(
                                              color: deepColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 18.h,
                              ),
                              Text(
                                formatDate,
                                style: const TextStyle(
                                  color: darkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    hijri.toFormat("dd MMMM || yyyy"),
                                    style: const TextStyle(
                                        color: deepColor,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_sharp,
                                        color: deepColor,
                                        size: 16.r,
                                      ),
                                      Text(
                                        location.address == null
                                            ? 'Searching..'
                                            : '${location.address},${location.address2}',
                                        style: const TextStyle(
                                          color: deepColor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //TODO: Category Icon
                Padding(
                  padding: EdgeInsets.only(top: 15.h, right: 14.w, left: 14.w),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shadowColor: primaryColor.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CategoryIcon(
                                  name: 'হাদিস',
                                  image: 'assets/hadith.png',
                                  size: 38,
                                  onCLick: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Hadith()));
                                  }
                              ),
                              CategoryIcon(
                                  name: '৯৯ নাম',
                                  image: 'assets/99names.png',
                                  onCLick: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllahNames()));
                                  }
                              ),
                              CategoryIcon(
                                  name: 'তাসবীহ',
                                  image: 'assets/tasbih.png',
                                  onCLick: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Tasbih()));
                                  }
                              ),
                              CategoryIcon(
                                  name: 'ভিডিও',
                                  image: 'assets/video_red.png',
                                  onCLick: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage()));
                                  }
                              ),
                              CategoryIcon(
                                  name: 'ক্বিবলা',
                                  size: 39,
                                  image: 'assets/qibla.png',
                                  onCLick: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const QiblaPage()));
                                  }
                              ),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(height: 2, color: waterColor),
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CategoryIcon(
                                  name: 'বই',
                                  image: 'assets/books.png',
                                  onCLick: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Books()));
                                  }
                              ),
                              CategoryIcon(
                                  name: 'ফাতওয়া',
                                  size: 39,
                                  image: 'assets/asked.png',
                                  onCLick: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Fatwa()));
                                  }
                              ),
                              CategoryIcon(
                                  name: 'ব্লগ',
                                  image: 'assets/blog.png',
                                  onCLick: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Blog()));
                                  }
                              ),
                              CategoryIcon(
                                  name: 'যাকাত',
                                  image: 'assets/zakat.png',
                                  onCLick: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Zakat()));
                                  }
                              ),
                              CategoryIcon(
                                  name: 'সেটিংস',
                                  image: 'assets/settings.png',
                                  onCLick: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage()));
                                  }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //TODO: Blog Card
                Padding(
                  padding: EdgeInsets.only(top: 18.h, right: 15.w, left: 15.w),
                  child: Container(
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: Image.asset('assets/email.png',
                                    height: 23.r),
                                backgroundColor: waterColor,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                        color: darkColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Stay Update',
                                    style: TextStyle(
                                      color: deepColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        box.get('is_image',defaultValue: true)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: CachedNetworkImage(
                                  imageUrl: box.get('image',
                                      defaultValue:
                                          'https://crud.appworld.top/ramadan.jpg'),
                                  errorWidget: (context, url, error) {
                                    return const Center(
                                      child: Text(
                                          'We do not have latest news today.'),
                                    );
                                  },
                                ),
                              )
                            : Text(
                                box.get('content',
                                    defaultValue: 'Alhamdulillah'),
                                style: const TextStyle(
                                  color: darkColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                      ],
                    ),
                  ),
                ),

                //TODO: Video Card
                Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Container(
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 7.h),
                          child: Row(
                            children: [
                              Container(
                                child: Image.asset('assets/video.png',
                                    height: 23.r),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.pinkAccent,
                                    )),
                                padding: const EdgeInsets.all(5),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              const Text(
                                'Essential Questions',
                                style: TextStyle(
                                    color: darkColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: kIsWeb
                            ? YoutubePlayerIFrame(
                               controller: web_controller,
                               aspectRatio: 16 / 9,
                            )
                              : native.YoutubePlayer(
                            controller: native_controller,
                            aspectRatio: 16/9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
