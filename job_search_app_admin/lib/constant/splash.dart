import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app_admin/auth/admin/admin_login.dart';
import 'package:job_search_app_admin/auth/user/login_auth.dart';
import 'package:job_search_app_admin/views/admin/home_view_admin.dart';
import 'package:job_search_app_admin/views/user/home_view.dart';
import 'package:job_search_app_admin/widget/constant.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Constant constant = Constant();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constant.secondaryColor,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 188,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: constant.primaryColor),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) =>
                                    FirebaseAuth.instance.currentUser == null
                                        ? AdminLogin()
                                        : HomeViewAdmin()));
                      },
                      child: Text(
                        "As a Admin",
                        style: TextStyle(
                            fontSize: 20, color: constant.lightBgColor),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 188,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: constant.primaryColor),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) =>
                                  FirebaseAuth.instance.currentUser == null
                                      ? LoginAuth()
                                      : HomeView()));
                    },
                    child: Text(
                      "As a User",
                      style:
                          TextStyle(fontSize: 20, color: constant.lightBgColor),
                    )),
              ),
            ],
          ),
        ));
  }
}
