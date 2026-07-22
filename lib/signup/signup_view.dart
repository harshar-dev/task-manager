import 'package:food_app/signup/signup_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class SignupView extends StatefulWidget {
   SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController name = TextEditingController();
   final TextEditingController email = TextEditingController();

   final TextEditingController password = TextEditingController();

   final controller = Get.put(SignupController());

   final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Create User"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: 
            SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                children: [
                  SizedBox(height: 50,),
                  TextFormField(
                decoration: InputDecoration(
                  labelText: "name",
                  border: OutlineInputBorder()),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "please fill your name";
                  }
                  return null;
                },
                controller: name,
              ),
              SizedBox(height: 15,),
                  
              TextFormField(
                decoration: InputDecoration(
                  labelText: "email",
                  border: OutlineInputBorder()),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "please fill field";
                  }
                  return null;
                },
                controller: email,
              ),
              SizedBox(height: 15,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "password",
                  border: OutlineInputBorder()),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "please fill field";
                  }
              
                  if(value.length < 6){
                    return "please enter above 6 lettrs";
                  }
              
                  return null;
                },
                controller: password,
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
                    controller.signup(name.text,email.text,password.text);
                  }
                  
                }, child: Text("Signup",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
              ),
              SizedBox(height: 10,),
                Text("or",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    
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
                        image: AssetImage('assets/google.png')),
                      SizedBox(width: 5,),
                      Text("Continue With Google",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    ],
                  )),
                ),
              SizedBox(height: 15,),
              TextButton(onPressed: (){
                Get.toNamed('/login');
              }, child: Text("already an user? login",style: TextStyle(fontSize: 15,color: Colors.red),))
                ],
              )),
            )
          
        
      )
    );
  }
}