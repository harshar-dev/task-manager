import 'package:flutter/material.dart';
import 'package:food_app/add_task/add_task_controller.dart';
import 'package:get/get.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {

  TextEditingController task = TextEditingController();
  TextEditingController timegoal = TextEditingController(); 
  final controller = Get.put(AddTaskController());
  final formkey = GlobalKey<FormState>();
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("add task"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return "please enter task";
                  }
                  return null;
                },
                controller: task,
                decoration: InputDecoration(
                  hintText: "Enter task",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(height: 15,),
              TextFormField(
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return "please enter duration end";
                  }
                  return null;
                },
                controller: timegoal,
                decoration: InputDecoration(
                  hintText: "Enter End Day",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(height: 15,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.all(10)
                  ),
                  onPressed: (){
                  if(formkey.currentState!.validate()){
                  controller.addtask(task.text, timegoal.text);
                  timegoal.clear();
                  task.clear();
                  }
                  
                }, child: Text("save task",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}