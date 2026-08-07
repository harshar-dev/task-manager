import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/payment_controller.dart';


class AddTaskController extends GetxController{
  
  final FirebaseAuth auth = FirebaseAuth.instance;
  final paymentController = Get.put(PaymentController());

  Future<void> addtask(String task,String timegoal)async{

   final datas = await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser?.uid).collection('habits').get();
   final userdata= await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser?.uid).get();



    if(datas.docs.length > 5 && userdata['isPremium'] == false){
      return Get.defaultDialog(
        title: "you need to go to premium",
        textConfirm: "pay",
        onConfirm: () {
          paymentController.payment();
        },
      );
    }


    await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).collection('habits').add({
      'task':task,
      'timegoal':timegoal,
      'completed':false,
      'createdAt':FieldValue.serverTimestamp()
    });

    Get.snackbar("added", "task added succesfully",duration: Duration(seconds: 1));
  }
}