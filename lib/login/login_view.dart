import 'package:food_app/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
   LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
   TextEditingController email = TextEditingController();

   TextEditingController password = TextEditingController();

   final formkey = GlobalKey<FormState>();

   final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("login page"),) ,

      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 50,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "email",
                    border: OutlineInputBorder()),
                  controller: email,
        
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "please enter valid email";
                    }
        
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "password",
                    border: OutlineInputBorder()),
                  controller: password,
        
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "please enter valid password";
                    }
        
                    if(value.length < 6){
                      return "please enter 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.all(15),
                        
                      ),
                    onPressed: (){
                    if(formkey.currentState!.validate()){
                      controller.login(email.text, password.text);
                    }
                    
                  }, child: Text("Login",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 10,),
                Text("or",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.all(15),
                      
                    ),
                  onPressed: (){
                  controller.googlesignin();
                }, child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      width: 25,
                      height: 25,
                      image: AssetImage('assets/google.png')), SizedBox(width: 5,),
                    Text("Continue With Google",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                  ],
                )),
        
                SizedBox(height: 15,),
              TextButton(onPressed: (){
                Get.toNamed('/signup');
              }, child: Text("not an user? signup",style: TextStyle(fontSize: 15,color: Colors.red)))
                  ],),
          )
        ),
      ),
    );
  }
}