// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Allow Location`
  String get allow_location {
    return Intl.message(
      'Allow Location',
      name: 'allow_location',
      desc: '',
      args: [],
    );
  }

  /// `Al Quran`
  String get al_quran {
    return Intl.message(
      'Al Quran',
      name: 'al_quran',
      desc: '',
      args: [],
    );
  }

  /// `Productive Muslim`
  String get app_name {
    return Intl.message(
      'Productive Muslim',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Verse`
  String get ayat {
    return Intl.message(
      'Verse',
      name: 'ayat',
      desc: '',
      args: [],
    );
  }

  /// `Bookmark`
  String get bookmark {
    return Intl.message(
      'Bookmark',
      name: 'bookmark',
      desc: '',
      args: [],
    );
  }

  /// `You can change the language later from the settings.`
  String get change_language_later {
    return Intl.message(
      'You can change the language later from the settings.',
      name: 'change_language_later',
      desc: '',
      args: [],
    );
  }

  /// `Hanafi`
  String get hanafi {
    return Intl.message(
      'Hanafi',
      name: 'hanafi',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Juz`
  String get juz {
    return Intl.message(
      'Juz',
      name: 'juz',
      desc: '',
      args: [],
    );
  }

  /// `Last Read`
  String get last_read {
    return Intl.message(
      'Last Read',
      name: 'last_read',
      desc: '',
      args: [],
    );
  }

  /// `Let's Begin`
  String get lets_begin {
    return Intl.message(
      'Let\'s Begin',
      name: 'lets_begin',
      desc: '',
      args: [],
    );
  }

  /// `We need your location to show you the nearest masjid and prayer times.`
  String get location_need_for {
    return Intl.message(
      'We need your location to show you the nearest masjid and prayer times.',
      name: 'location_need_for',
      desc: '',
      args: [],
    );
  }

  /// `Location Permission`
  String get location_permission {
    return Intl.message(
      'Location Permission',
      name: 'location_permission',
      desc: '',
      args: [],
    );
  }

  /// `Prayer`
  String get prayer {
    return Intl.message(
      'Prayer',
      name: 'prayer',
      desc: '',
      args: [],
    );
  }

  /// `Quran`
  String get quran {
    return Intl.message(
      'Quran',
      name: 'quran',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get select_laguage {
    return Intl.message(
      'Select Language',
      name: 'select_laguage',
      desc: '',
      args: [],
    );
  }

  /// `Select Madhab`
  String get select_madhab {
    return Intl.message(
      'Select Madhab',
      name: 'select_madhab',
      desc: '',
      args: [],
    );
  }

  /// `Please select madhab according to your school of thought.`
  String get select_madhab_according_of {
    return Intl.message(
      'Please select madhab according to your school of thought.',
      name: 'select_madhab_according_of',
      desc: '',
      args: [],
    );
  }

  /// `Shafi, Maliki, Hanbali`
  String get shafi_maliki_hanbali {
    return Intl.message(
      'Shafi, Maliki, Hanbali',
      name: 'shafi_maliki_hanbali',
      desc: '',
      args: [],
    );
  }

  /// `Surah`
  String get surah {
    return Intl.message(
      'Surah',
      name: 'surah',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task {
    return Intl.message(
      'Task',
      name: 'task',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'bn'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
