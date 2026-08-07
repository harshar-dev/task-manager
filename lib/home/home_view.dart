import 'package:flutter/material.dart';
import 'package:food_app/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final controller = Get.put(HomeController());
  
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(onPressed: (){
            controller.signout();
          }, icon: Icon(Icons.logout,color: Colors.white,))
        ],
        title: Text(controller.greetings(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),),
      body: Obx((){
        

          if(controller.habits.isEmpty){
            
            return  Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi ${controller.user['name']}",style: TextStyle(fontSize: 20),),
                    Expanded(child: Center(child: Text("no habits yet")))
                  ],
                ),

                
            );

            
            
             
          }

          

        
          
        return Column(
          children: [
                   SizedBox(
                    width: double.infinity,
                     child: Card(
                      elevation: 5,
                       child: Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: Column(
                          
                          children: [
                                     Text("Hi ${controller.user['name']}",style: TextStyle(fontSize: 25),),
                                     Text("Total Task : ${controller.habits.length}",style: TextStyle(fontSize: 18),),
                                     Text("Completed : ${controller.habits.where((habit)=> habit['completed']==true).length}",style: TextStyle(fontSize: 18),),
                                     Text("Pending : ${controller.habits.length - controller.habits.where((habit)=> habit['completed']==true).length}",style: TextStyle(fontSize: 18),),
                          ],
                         ),
                       ),
                     ),
                   ),
         

            Expanded(
              child: ListView.builder(
              itemCount: controller.habits.length,
              itemBuilder: (context,index){
                final data = controller.habits[index];
              
                
                
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Card(
                    child: ListTile(
                      
                      leading: Checkbox(value: data['completed'], onChanged: (value){
                        FirebaseFirestore.instance.collection('Users').doc(auth.currentUser?.uid).collection('habits').doc(data['id']).update({'completed':value});
                      
                      }),
                      title: Text(data['task']),
                      subtitle: Text(data['timegoal']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){
                            Get.defaultDialog(
                              title: "Delete",
                              textConfirm: "Delete",
                              textCancel: "Cancel",
                              middleText: "Are you sure want to delete",
                              onConfirm: (){
                                controller.delete(data['id']);
                              }
                            );
                        
                      }, icon: Icon(Icons.delete,color: Colors.red,)),
              
                      IconButton(onPressed: (){
                        TextEditingController task = TextEditingController();
                        TextEditingController timegoal = TextEditingController();
                        Get.defaultDialog(
                          content: Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(hintText: data['task']),
                                controller: task,),
                              TextField(
                                decoration: InputDecoration(hintText: data['timegoal']),
                                controller: timegoal,)
                            ],
                          ),
                          textCancel: "no",
                          title: "Edit",
                          textConfirm: "edit",
                          onConfirm: (){
                            controller.edit(data['id'],task.text.isEmpty ? data['task'] : task.text,timegoal.text.isEmpty ? data['timegoal'] : timegoal.text);
                            Get.back();
                          }
                          
                        );
                      }, icon: Icon(Icons.edit,color: Colors.blueGrey,))
                        ],
                      )
                      
                    ),
                  ),
                );
                
                    }),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Get.toNamed('/add-task');
      }),
    );
  }
}