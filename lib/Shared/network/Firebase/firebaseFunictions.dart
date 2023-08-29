import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/TaskModel.dart';

class firebaseFunictions {
  static CollectionReference<TaskModel>getTasksCollection(){
    return FirebaseFirestore.instance.collection('Tasks').withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromjson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.Tojson();
      },
    );
  }
  static Future<void> addTasks(TaskModel Task) {
    var collection=getTasksCollection();
    var doc=collection.doc();
    Task.id=doc.id;
    return doc.set(Task);
  }
  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime dateTime){
    return getTasksCollection().where("date",isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
        .snapshots();
  }

   static Future<void>deleteTask(String id){
    return getTasksCollection().doc(id).delete();
  }
  static Future<void> updateTask(String id,TaskModel taskModel){
    return getTasksCollection().doc(id).update(taskModel.Tojson());
  }
}
