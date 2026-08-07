import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginController extends GetxController{

    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googlesign = GoogleSignIn.instance;

    Future<void> login(String email, String password) async{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home');
    }

    Future<void> googlesignin()async{
      await googlesign.initialize();

      final user = await googlesign.authenticate();

      final googleuser =  user.authentication;

      final userCredential = GoogleAuthProvider.credential(
        idToken: googleuser.idToken
      ); 

      await auth.signInWithCredential(userCredential);

      await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser?.uid).set({
        'name' : user.displayName,
        'email' : user.email,
        'id' : auth.currentUser?.uid,
        'photoUrl' : user.photoUrl,
        'isPremium' :false
      });

      

      Get.offAllNamed('/home');


    }
}