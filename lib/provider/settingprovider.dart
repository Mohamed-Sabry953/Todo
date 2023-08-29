import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/themes/ThemeData.dart';

class settingprovider extends ChangeNotifier{
ThemeMode mode=ThemeMode.light;
String language='en';
changetheme(ThemeMode Theme){
  mode=Theme;
  notifyListeners();
}
changelanguage(String lang){
  language=lang;
  notifyListeners();
}
}