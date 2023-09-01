
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Homelayout.dart';
import 'package:todo/Taps/ListTap/listTap.dart';
import 'package:todo/Taps/editTap.dart';
import 'package:todo/login/LoginPage.dart';
import 'package:todo/provider/settingprovider.dart';
import 'package:todo/signUp/signup.dart';
import 'package:todo/themes/ThemeData.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( ChangeNotifierProvider(create: (context)=>settingprovider(),
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<settingprovider>(context);
    return MaterialApp(
      title: 'Localizations Sample App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(provider.language),
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightmode,
      darkTheme: MyThemeData.darkmode,
      themeMode: provider.mode,
      initialRoute:Homelayout.routeName,
      routes: {
        Homelayout.routeName:(context)=>Homelayout(),
        editTask.routeName:(context)=>editTask(),
        Login.routeName:(context)=>Login(),
        Signup.routeName:(context)=>Signup(),
      },
    );
  }
}
