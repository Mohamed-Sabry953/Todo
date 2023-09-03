import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Taps/SettingTap.dart';
import 'package:todo/Taps/ListTap/listTap.dart';
import 'package:todo/bottomButtonSheet/bottomButtonSheetAddTask.dart';
import 'package:todo/login/LoginPage.dart';
import 'package:todo/provider/settingprovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Homelayout extends StatefulWidget {
  static const String routeName = 'Homelayout';

  @override
  State<Homelayout> createState() => _HomelayoutState();
}

class _HomelayoutState extends State<Homelayout> {
  List<Widget> screens = [ListTap(), SettingTap()];
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<settingprovider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(currentindex == 0 ? 'ToDoList' : AppLocalizations.of(context)!.appsetting),
        actions: [
          IconButton(onPressed:(){
            provider.Logout();
            Navigator.pushNamedAndRemoveUntil(context, Login.routeName, (route) => false);
          }, icon: Icon(Icons.login_outlined),iconSize: 30,)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color:
            provider.mode == ThemeMode.light ? Colors.white : Color(0xff141922),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: '',
                backgroundColor: Colors.transparent),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: '',
                backgroundColor: Colors.transparent)
          ],
          currentIndex: currentindex,
          onTap: (value) {
            currentindex = value;
            setState(() {});
          },
        ),
      ),
      body: screens[currentindex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(

        shape: CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 3,
          )
        ),
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            Showbottomsheet();
          },
          icon: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }

  Showbottomsheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: bottomButtonSheet(),
        );
      },
    );
  }
}
