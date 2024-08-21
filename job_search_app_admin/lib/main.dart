import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app_admin/auth/admin/admin_register.dart';
import 'package:job_search_app_admin/auth/user/register_auth.dart';
import 'package:job_search_app_admin/constant/splash.dart';
import 'package:job_search_app_admin/todo_app/auth/user/register_auth.dart';
import 'package:job_search_app_admin/todo_app/auth/user/splash_todo.dart';
import 'package:job_search_app_admin/todo_app/home_view_todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}
