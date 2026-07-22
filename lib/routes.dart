import 'package:food_app/add_task/add_task_view.dart';
import 'package:food_app/home/home_view.dart';
import 'package:food_app/login/login_view.dart';
import 'package:food_app/signup/signup_view.dart';
import 'package:get/get.dart';




routes() => [
  GetPage(
    
    name: '/login', page: ()=>LoginView()),
  GetPage(
    
    name: '/signup', page: ()=>SignupView()),
  GetPage(
    transition: Transition.rightToLeftWithFade,
    name: '/home', page: ()=>HomeView()),
  GetPage(
    transition: Transition.rightToLeftWithFade,
    name: '/add-task', page: ()=>AddTaskView())
];