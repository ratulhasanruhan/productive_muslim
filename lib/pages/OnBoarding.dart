import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:productive_muslim/controller/langController.dart';
import 'package:productive_muslim/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../screen/MainPage.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  bool isBengali = true;
  bool isHanafi = true;
  var box = Hive.box('home');

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;

    return ScreenUtilInit(
      builder: (context, child) {
        return OnBoardingSlider(
            totalPage: 3,
            headerBackgroundColor: Colors.white,
            background: [
              Container(),
              Container(),
              Container(),
            ],
            controllerColor: kGreen,
            speed: 1.8,
          pageBackgroundColor: Colors.white,
          finishButtonText: lang.lets_begin,
          finishButtonStyle: FinishButtonStyle(
            foregroundColor: kGreen,
            backgroundColor: kGreen,
          ),
          finishButtonTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Sofia Bold',
          ),
          onFinish: () {
            box.put('onboard', false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            );
          },
          pageBodies: [
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Lottie.asset(
                    'assets/language_icon.json',
                    height: 180.h,
                    fit: BoxFit.contain,
                    reverse: true,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    lang.select_laguage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: CheckboxListTile(
                        value: !isBengali,
                        onChanged: (value) {
                          setState(() {
                            isBengali = false;
                            context.read<LangController>().changeLang('en');
                          });
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        title: Text(
                            'English',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        activeColor: kGreen,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                        ),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: CheckboxListTile(
                        value: isBengali,
                        onChanged: (value) {
                          setState(() {
                            isBengali = true;
                            context.read<LangController>().changeLang('bn');
                          });
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        title: Text(
                          'বাংলা',
                          style: TextStyle(
                            fontFamily: 'Ador Bold'
                          ),
                        ),
                        activeColor: kGreen,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(lang.change_language_later,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey.shade200,
                    ),
                  ),


                ],
              ),
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Lottie.asset(
                  'assets/masjid_icon.json',
                  height: 200.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  lang.select_madhab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: CheckboxListTile(
                      value: isHanafi,
                      onChanged: (value) {
                        setState(() {
                          isHanafi = true;
                          box.put('madhab', 'Hanafi');
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      title: Text(
                        lang.hanafi,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      activeColor: kGreen,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: CheckboxListTile(
                      value: !isHanafi,
                      onChanged: (value) {
                        setState(() {
                          isHanafi = false;
                          box.put('madhab', 'Shafi');
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      title: Text(
                        lang.shafi_maliki_hanbali,
                        style: TextStyle(
                            fontFamily: 'Ador Bold'
                        ),
                      ),
                      activeColor: kGreen,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(lang.select_madhab_according_of,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey.shade200,
                  ),
                ),


              ],
            ),
            ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset(
                    'assets/location_icon.json',
                    height: 200.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  lang.location_permission,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 40.h,
                ),
                Text(
                  lang.location_need_for,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey.shade200,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),

                OutlinedButton(
                    onPressed: () async{
                      await Geolocator.requestPermission();
                      if (await Geolocator.isLocationServiceEnabled()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ));
                      }
                    },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: kGreen.withValues(alpha: 0.2)
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                    child: Text(
                        lang.allow_location,
                      style: TextStyle(
                        color: kGreen,
                      ),
                    ),
                )



              ],
            ),
            ],

        );
      }
    );
  }
}
