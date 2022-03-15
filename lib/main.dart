import 'package:badges/badges.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:productive_muslim/constant.dart';
import 'package:productive_muslim/controller/locationProvider.dart';
import 'package:productive_muslim/controller/task_controller.dart';
import 'package:productive_muslim/model/TaskModel.dart';
import 'package:productive_muslim/screen/Home.dart';
import 'package:productive_muslim/screen/Prayers.dart';
import 'package:productive_muslim/screen/Quran.dart';
import 'package:productive_muslim/screen/Task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(ModelTaskAdapter());
  }
  await Hive.openBox('home');
  await Hive.openBox('hadith');
  await Hive.openBox('task');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => TaskController()),
      ],
      child: MaterialApp(
        title: 'Productive Muslim',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color(0xFF00C493),
            secondary: Color(0xFF4DC591),
          ),
          fontFamily: 'Sofia',
        ),
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    )
  );
}


class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  QuickActions quickActions = QuickActions();

  @override
  void initState() {
    super.initState();
    quickActions.initialize((String shortcutType) {
      if(shortcutType == 'task'){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage()));
      }
      if(shortcutType == 'salat'){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerPage()));
      }
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: 'task',
        localizedTitle: 'Task',
        icon: 'mipmap/ic_launcher',
      ),
      ShortcutItem(
        type: 'salat',
        localizedTitle: 'Salat',
        icon: 'mipmap/ic_launcher',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    context.read<LocationProvider>().getLocation(context);
    var taskLength = Provider.of<TaskController>(context).taskBox.length;

    return Scaffold(
      backgroundColor: backColor,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)
        ),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: deepColor,
          selectedItemColor: primaryColor,
          currentIndex: index,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Sofia Bold',
          ),
          onTap: (sindex){
            setState(() {
              index = sindex;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined),
                label: 'Quran'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.watch_later_outlined),
                label: 'Prayers'
            ),
            BottomNavigationBarItem(
                label: 'Task',
                icon: Badge(
                  showBadge: taskLength ==0 ? false : true,
                  badgeContent: Text(taskLength.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  child: Icon(Icons.task_alt),
                ),
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
}
