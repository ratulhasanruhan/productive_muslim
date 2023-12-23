import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../controller/locationProvider.dart';
import '../controller/task_controller.dart';
import '../utils/colors.dart';
import 'Home.dart';
import 'Prayers.dart';
import 'Quran.dart';
import 'Task.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    context.read<LocationProvider>().getLocation(context);

    return ScreenUtilInit(
      builder:(context, child) {
        return Scaffold(
          backgroundColor: backColor,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(22.r),
                topLeft: Radius.circular(22.r)
            ),
            child: BottomNavyBar(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              selectedIndex: index,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeInCubic,
              onItemSelected: (i) => setState(() => index = i),
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(FeatherIcons.home),
                  title: Text(AppLocalizations.of(context)!.home),
                  activeColor: Color(0xFF4E525B),
                  textAlign: TextAlign.center,
                  inactiveColor: Color(0xFF4E525B),
                ),
                BottomNavyBarItem(
                  icon: Icon(FeatherIcons.bookOpen),
                  title: Text(AppLocalizations.of(context)!.quran),
                  activeColor: Color(0xFF4E525B),
                  textAlign: TextAlign.center,
                  inactiveColor: Color(0xFF4E525B),
                ),
                BottomNavyBarItem(
                  icon: Icon(FeatherIcons.clock),
                  title: Text(AppLocalizations.of(context)!.prayer),
                  activeColor: Color(0xFF4E525B),
                  textAlign: TextAlign.center,
                  inactiveColor: Color(0xFF4E525B),
                ),
                BottomNavyBarItem(
                  icon: Icon(FeatherIcons.checkCircle),
                  title: Text(AppLocalizations.of(context)!.task),
                  activeColor: Color(0xFF4E525B),
                  textAlign: TextAlign.center,
                  inactiveColor: Color(0xFF4E525B),
                ),
              ],
            ),
          ),
          body: IndexedStack(
            index: index,
            children: [
              HomePage(),
              QuranPage(),
              PrayerPage(),
              TaskPage(),
            ],
          ),
        );
      }
    );
  }
}