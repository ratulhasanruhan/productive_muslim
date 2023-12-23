import 'package:badges/badges.dart' as badge;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:productive_muslim/controller/langController.dart';
import 'package:productive_muslim/controller/locationProvider.dart';
import 'package:productive_muslim/controller/task_controller.dart';
import 'package:productive_muslim/model/TaskModel.dart';
import 'package:productive_muslim/screen/Home.dart';
import 'package:productive_muslim/screen/MainPage.dart';
import 'package:productive_muslim/pages/OnBoarding.dart';
import 'package:productive_muslim/screen/Prayers.dart';
import 'package:productive_muslim/screen/Quran.dart';
import 'package:productive_muslim/screen/Task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:productive_muslim/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        ChangeNotifierProvider(create: (_) => LangController()),
        ChangeNotifierProvider(create: (_) => TaskController()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  QuickActions quickActions = const QuickActions();

  @override
  void initState() {
    super.initState();
    quickActions.initialize((String shortcutType) {
      if(shortcutType == 'task'){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  TaskPage()));
      }
      if(shortcutType == 'salat'){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  PrayerPage()));
      }
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'task',
        localizedTitle: 'Task',
        icon: 'mipmap/ic_launcher',
      ),
      const ShortcutItem(
        type: 'salat',
        localizedTitle: 'Salat',
        icon: 'mipmap/ic_launcher',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productive Muslim',
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('bn', 'BD'), // Bangla
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(context.watch<LangController>().lang),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF00C493),
          secondary: const Color(0xFF4DC591),
        ),
        fontFamily: 'Ador',
      ),
      debugShowCheckedModeBanner: false,
      home: Hive.box('home').get('onboard', defaultValue: true)
          ?  OnBoarding()
          :  MainPage(),
    );
  }
}


