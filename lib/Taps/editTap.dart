import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Shared/network/Firebase/firebaseFunictions.dart';
import 'package:todo/models/TaskModel.dart';
import 'package:todo/provider/settingprovider.dart';
import 'package:todo/themes/ThemeData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class editTask extends StatefulWidget {
  static const String routeName = "edit";

  @override
  State<editTask> createState() => _editTaskState();
}

class _editTaskState extends State<editTask> {
  var formKey = GlobalKey<FormState>();
  var selcetedDate = DateTime.now();

  var titlecontroler = TextEditingController();
  var descrebtioncontroler = TextEditingController();
  String editTitle = '';
  String editdescrebtion = '';

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<settingprovider>(context);
    var args = ModalRoute.of(context)?.settings.arguments as TaskModel;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: MyThemeData.light,
            width: double.infinity,
            height: 140,
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back,size: 30,color: Colors.white,))
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color:provider.mode==ThemeMode.light?Colors.white:MyThemeData.dark,
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsetsDirectional.only(
                start: 20, end: 20, top: 90, bottom: 35),
            height: double.infinity,
            width: double.infinity,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(15.0),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.edittask,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: provider.mode==ThemeMode.light?MyThemeData.dark:Colors.white,
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: 10, end: 10, bottom: 20),
                      child: TextFormField(
                        style: TextStyle(
                            color: provider.mode==ThemeMode.light?MyThemeData.dark:Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        initialValue: args.title.toString(),
                        onChanged: (value) {
                          edittitle(value, args.title.toString());
                        },
                        maxLines: 3,
                        validator: (value) {
                          if (value.toString().length < 4) {
                            return 'at least 4 char';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyThemeData.light,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyThemeData.light,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.only(start: 15, top: 30)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: 10, end: 10, bottom: 20),
                      child: TextFormField(
                        initialValue: args.descrebtion.toString(),
                        onChanged: (value) {
                          editDescrebtion(value, args.descrebtion.toString());
                        },
                        maxLength: 150,
                        style: TextStyle(
                            color:provider.mode==ThemeMode.light?MyThemeData.dark:Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        maxLines: 7,
                        validator: (value) {
                          if (value.toString().length < 20) {
                            return 'at least 20 char';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyThemeData.light,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyThemeData.light,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.only(start: 15, top: 30)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: 30, end: 30, bottom: 20),
                      width: double.infinity,
                      child: Text(
                        AppLocalizations.of(context)!.selecttime,
                        style: TextStyle(
                          color: provider.mode==ThemeMode.light?MyThemeData.dark:Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showdatetime();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsetsDirectional.only(
                            start: 30, end: 30, bottom: 20),
                        width: double.infinity,
                        child: Text(
                          selcetedDate.toString().substring(0, 10),
                          style: TextStyle(
                            color: provider.mode==ThemeMode.light?MyThemeData.dark:Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        firebaseFunictions
                            .updateTask(
                                args.id.toString(),
                                TaskModel(
                                  UserId: FirebaseAuth.instance.currentUser!.uid,
                                    id: args.id.toString(),
                                    title: editTitle,
                                    descrebtion: editdescrebtion,
                                    date: DateUtils.dateOnly(selcetedDate)
                                        .millisecondsSinceEpoch,
                                    IsDone: args.IsDone))
                            .then((value) => Navigator.pop(context));
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        margin: EdgeInsetsDirectional.only(
                            start: 40, end: 40, bottom: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: MyThemeData.light,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: MyThemeData.light)),
                        child: Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showdatetime() async {
    DateTime? selcetedtime = await showDatePicker(
        context: context,
        initialDate: selcetedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (selcetedtime != null) {
      selcetedDate = selcetedtime;
      setState(() {});
    }
  }

  void edittitle(String val, String args) {
    if (val == args) {
      editTitle = args;
    } else {
      editTitle = val;
    }
  }

  void editDescrebtion(val, String args) {
    if (val == args) {
      editdescrebtion = args;
    } else {
      editdescrebtion = val;
    }
  }
}
