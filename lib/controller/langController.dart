import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class LangController extends ChangeNotifier {
  var lang = Hive.box('home').get('language', defaultValue: 'bn');

  void changeLang(String newLang) {
    Hive.box('home').put('language', newLang);
    lang = newLang;
    notifyListeners();
  }

}