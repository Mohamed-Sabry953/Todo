import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  static Future<void>Signup(String email,String password,Function Nav)async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,).then((value){
          Nav();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  static Future<void>Loign(String email,String password,Function Nav) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value){
        Nav();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
