

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Shared/network/Firebase/firebaseFunictions.dart';
import 'package:todo/Taps/ListTap/ListCard.dart';
import 'package:todo/models/TaskModel.dart';
import 'package:todo/provider/settingprovider.dart';
import 'package:todo/themes/ThemeData.dart';

class ListTap extends StatefulWidget {

  @override
  State<ListTap> createState() => _ListTapState();
}
   DateTime selectedDate=DateTime.now();

class _ListTapState extends State<ListTap> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<settingprovider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate=date;
            setState(() {

            });
          },
          leftMargin: 20,
          monthColor: MyThemeData.light,
          dayColor: MyThemeData.light,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: MyThemeData.light,
          dotsColor: Color(0xFF333A47),
          selectableDayPredicate: (date) => date.day != 23,
          locale: provider.language,
        ),
        SizedBox(height: 20,),
        StreamBuilder(
          stream: firebaseFunictions.getTask(selectedDate), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text('something went error');
          }

          var task = snapshot.data?.docs.map((e)=>e.data()).toList() ?? [];
          if(task.isEmpty){
            return Center(child: Text('No tasks is add',style: Theme.of(context).textTheme.bodyMedium,));
          }
          return Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return ListCard(task[index]);
            }, itemCount:task.length),
          );
        },)
      ],
    );
  }
}
