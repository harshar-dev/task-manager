import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddTaskController extends GetxController{
  
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addtask(String task,String timegoal)async{
    await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).collection('habits').add({
      'task':task,
      'timegoal':timegoal,
      'completed':false,
      'createdAt':FieldValue.serverTimestamp()
    });

    Get.snackbar("added", "task added succesfully",duration: Duration(seconds: 1));
  }
}