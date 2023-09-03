import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Shared/network/Firebase/firebaseFunictions.dart';
import 'package:todo/login/LoginPage.dart';
import 'package:todo/models/User_model.dart';
import 'package:todo/themes/ThemeData.dart';

class settingprovider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  String language = 'en';
  UserModel? userModel;
  User? firebaseuser;

  changetheme(ThemeMode Theme) {
    mode = Theme;
    notifyListeners();
  }

  changelanguage(String lang) {
    language = lang;
    notifyListeners();
  }

  autoLogin() {
    firebaseuser = FirebaseAuth.instance.currentUser;
    if (firebaseuser != null) {
      initMyuser();
    }
  }

  void initMyuser() async {
    userModel = await firebaseFunictions.ReadData(firebaseuser!.uid);
  }

  Logout() {
    FirebaseAuth.instance.signOut();
  }
}
