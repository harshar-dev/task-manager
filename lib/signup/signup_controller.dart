import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignupController extends GetxController{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googlesign = GoogleSignIn.instance;
  

  Future<void> signup(String name,String email,String password) async{
     
     
     await auth.createUserWithEmailAndPassword(email: email, password: password);

     await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser?.uid).set({
      'name':name,
      'email':email,
      'password':password,
      'id':auth.currentUser?.uid,
      'isPremium' :false
     });
     
     Get.offAllNamed('/home');
  }

  Future<void> googlesignin()async{
     await googlesign.initialize();
     final user = await googlesign.authenticate();

     final googleuser = user.authentication;

     final credential = GoogleAuthProvider.credential(
      idToken: googleuser.idToken
     );

     await auth.signInWithCredential(credential);

      await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser?.uid).set({
      'name' : user.displayName,
      'email' : user.email,
      'id' : auth.currentUser?.uid,
      'isPremium' :false

     });

     Get.offAllNamed('/home');
  }

  
}