import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/Shared/network/Firebase/firebaseFunictions.dart';
import 'package:todo/Taps/editTap.dart';
import 'package:todo/models/TaskModel.dart';
import 'package:todo/provider/settingprovider.dart';
import 'package:todo/themes/ThemeData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListCard extends StatefulWidget {
  TaskModel Taskmodel;

  ListCard(this.Taskmodel, {super.key});

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<settingprovider>(context);
    return Card(
      margin: EdgeInsetsDirectional.only(start: 10, end: 15, top: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                firebaseFunictions.deleteTask(widget.Taskmodel.id);
              },
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, editTask.routeName,
                    arguments: TaskModel(
                      UserId: FirebaseAuth.instance.currentUser!.uid,
                        title: widget.Taskmodel.title,
                        descrebtion: widget.Taskmodel.descrebtion,
                        date: widget.Taskmodel.date,
                        IsDone: widget.Taskmodel.IsDone,
                        id: widget.Taskmodel.id));
              },
              borderRadius: BorderRadius.circular(10),
              backgroundColor: MyThemeData.light,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 20, top: 30, bottom: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: provider.mode==ThemeMode.light?Colors.white:MyThemeData.dark,
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 5),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
              width: 4,
              color: widget.Taskmodel.IsDone == false
                  ? MyThemeData.light
                  : Colors.green,
            ))),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.Taskmodel.title,
                        style: TextStyle(
                            color: widget.Taskmodel.IsDone == false
                                ? MyThemeData.light
                                : Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        widget.Taskmodel.descrebtion,
                        style: TextStyle(
                            color:provider.mode==ThemeMode.light?Colors.black:Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    firebaseFunictions.updateTask(
                        widget.Taskmodel.id,
                        TaskModel(
                          UserId: FirebaseAuth.instance.currentUser!.uid,
                            title: widget.Taskmodel.title,
                            descrebtion: widget.Taskmodel.descrebtion,
                            date: widget.Taskmodel.date,
                            IsDone: true,
                            id: widget.Taskmodel.id));
                  },
                  child: widget.Taskmodel.IsDone == false
                      ? Icon(
                          Icons.done,
                        )
                      : Text(
                          AppLocalizations.of(context)!.isdone,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: widget.Taskmodel.IsDone == false
                          ? MyThemeData.light
                          : Colors.green,
                      fixedSize: Size(80, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
