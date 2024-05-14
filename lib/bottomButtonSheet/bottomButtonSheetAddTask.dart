import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Shared/network/Firebase/firebaseFunictions.dart';
import 'package:todo/models/TaskModel.dart';
import 'package:todo/provider/settingprovider.dart';
import 'package:todo/themes/ThemeData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class bottomButtonSheet extends StatefulWidget {
  @override
  State<bottomButtonSheet> createState() => _bottomButtonSheetState();
}

class _bottomButtonSheetState extends State<bottomButtonSheet> {
  var formKey = GlobalKey<FormState>();
  var selcetedDate = DateTime.now();
  var titlecontroler = TextEditingController();
  var descrebtioncontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<settingprovider>(context);
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Container(
          color: provider.mode==ThemeMode.light?Colors.white:MyThemeData.dark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin:const EdgeInsets.only(top: 25.0) ,
                  alignment: Alignment.topLeft,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back,size: 30,color: MyThemeData.light,))),
              Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.newtask,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: provider.mode==ThemeMode.light?MyThemeData.dark:Colors.white,
                      ),
                  )),
              SizedBox(
                height: 40,
              ),
              Container(
                margin:
                    EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 20),
                child: TextFormField(
                  style: TextStyle(

                      color:provider.mode==ThemeMode.light?MyThemeData.dark:Colors.white
                      ,fontSize: 20,fontWeight: FontWeight.w500
                  ),
                  controller: titlecontroler,
                  maxLines: 1,
                  validator: (value) {
                    if (value.toString().length < 4) {
                      return 'at least 4 char';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyThemeData.light,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      labelText: AppLocalizations.of(context)!.titlelabel,
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsetsDirectional.only(start: 15,top: 60)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin:
                    EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 20),
                child: TextFormField(
                  maxLength: 150,
                  style: TextStyle(

                    color: provider.mode==ThemeMode.light?MyThemeData.dark:Colors.white,
                      fontSize: 20,fontWeight: FontWeight.w500
                  ),
                  controller: descrebtioncontroler,
                  maxLines: 7,
                  validator: (value) {
                    if (value.toString().length < 20) {
                      return 'at least 20 char';
                    }
                    return null;
                  },
                  decoration: InputDecoration(

                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: MyThemeData.light,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      labelText: AppLocalizations.of(context)!.describtionlabel,
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsetsDirectional.only(start: 15,top: 40)),
                ),
              ),
              Container(
                margin:
                    EdgeInsetsDirectional.only(start: 30, end: 30, bottom: 20),
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
                  margin:
                      EdgeInsetsDirectional.only(start: 30, end: 30, bottom: 25),
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
                  if(formKey.currentState!.validate()){
                  TaskModel Task = TaskModel(
                    id: firebaseFunictions.getTasksCollection().id,
                      title: titlecontroler.text,
                      descrebtion: descrebtioncontroler.text,
                      date: DateUtils.dateOnly(selcetedDate).millisecondsSinceEpoch,
                      IsDone: false);
                  firebaseFunictions.addTasks(Task).then((value){
                    Navigator.pop(context);
                  });
                  }
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  margin:
                      EdgeInsetsDirectional.only(start: 40, end: 40, bottom: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: MyThemeData.light,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: MyThemeData.light)),
                  child: Text(
                    'Add Task',
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
}
