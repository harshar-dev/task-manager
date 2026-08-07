import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentController extends GetxController{

   late Razorpay razorpay;
   final FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void onInit() {
      razorpay = Razorpay();
      
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);

      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

      //razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.onInit();
  }


  Future<void> payment()async{
    Map<String , dynamic> options = {
    'key': 'rzp_test_TMkXuq0KDN4ZEh',
    'amount': 1000,
    'name': 'Task Manager',
    'description': 'premium payment for more add task',

    'prefill': {
      'contact': '9025316281',
      'email': 'test@gmail.com'
    }
  };


  try {
    razorpay.open(options);
  } catch(e) {
    print(e);
  }
  }

  

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response)async{
    await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser?.uid).update({
      'isPremium' : true
    });

    Get.snackbar('success', 'payment success');
  }

  Future<void> _handlePaymentError(PaymentFailureResponse response)async{
    Get.snackbar('error', 'payment incompleted');
  }
  
}