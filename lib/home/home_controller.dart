import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class HomeController extends GetxController{

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googlesign = GoogleSignIn.instance;

  final habits = [].obs;
  final user = {}.obs;

  @override
  void onInit() {
    fetchhabits();
    fetchUser();
    greetings();
    super.onInit();
  }

  Future<void> fetchhabits()async{
    await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser?.uid).collection('habits').orderBy('createdAt',descending: true).snapshots().listen((snapshot){
      habits.value = snapshot.docs.map((doc)=>{...doc.data(),'id':doc.id}).toList();
    });
  }

  void signout()async{

    await Get.defaultDialog(
      barrierDismissible: false,
      title: "Logout",
      textConfirm: "Logout",
      textCancel: "No",
      middleText: "Are you sure want to logout",
      onConfirm: ()async{
         await googlesign.signOut();
        await auth.signOut();
        Get.offAllNamed('/login');

      }
    );
    
     }

  Future<void> delete(String id)async{
    await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser?.uid).collection('habits').doc(id).delete();
    Get.back();
  }

  Future<void> fetchUser() async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(auth.currentUser!.uid)
      .snapshots().listen((snapshot){
        user.value = snapshot.data()!;
      });

  
}

  Future<void> edit(String id,String task,String timegoal)async{
    await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser?.uid).collection('habits').doc(id).update({
      'task':task,
      'timegoal':timegoal
    });
  }

  String greetings(){
    final hour = DateTime.now().hour;
    if(hour < 12){
      return "Good Morning";
    }
    else if(hour < 17){
      return "Good Afternoon";
    }
    else if(hour < 21){
      return "Good Evening";
    }

    return "Good night";
  }


}