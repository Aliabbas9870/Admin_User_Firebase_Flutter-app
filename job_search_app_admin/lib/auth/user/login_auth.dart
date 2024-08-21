import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app_admin/auth/user/forget_pass.dart';
import 'package:job_search_app_admin/auth/user/register_auth.dart';
import 'package:job_search_app_admin/views/user/home_view.dart';
import 'package:job_search_app_admin/widget/ASM.dart';
import 'package:job_search_app_admin/widget/constant.dart';
import 'package:job_search_app_admin/widget/loading.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginAuth extends StatefulWidget {
  const LoginAuth({super.key});

  @override
  State<LoginAuth> createState() => LoginAuthState();
}

class LoginAuthState extends State<LoginAuth> {
  final Constant constant = Constant();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final Asm ASM = Asm();

 loginUser() {
  // Show the loading indicator
  QuickAlert.show(
    context: context,
    type: QuickAlertType.loading,
    title: 'Please wait',
    text: '',
  );

  FirebaseFirestore.instance.collection("Users").get().then((snapShot) {
    bool userFound = false;
    snapShot.docs.forEach((result) {
      if (result.data()['email'] == emailController.text.trim()) {
        userFound = true;
        if (result.data()['password'] == passwordController.text.trim()) {
          // Close the loading dialog
          Navigator.of(context).pop();

          // Navigate to HomeView
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => HomeView()));
        } else {
          // Close the loading dialog
          Navigator.of(context).pop();

          QuickAlert.show(
            context: context,
            autoCloseDuration: Duration(seconds: 1),
            type: QuickAlertType.error,
            title: "Error",
            text: 'Your password is not correct',
          );
        }
      }
    });

    if (!userFound) {
      // Close the loading dialog
      Navigator.of(context).pop();

      QuickAlert.show(
        context: context,
        autoCloseDuration: Duration(seconds: 1),
        type: QuickAlertType.error,
        title: "Error",
        text: 'Your email is not correct',
      );
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50.0, left: 15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  constant.bgColor,
                  constant.lightBgColor,
                  constant.secondaryColor
                ])),
                child: Text(
                  "Hello\nsign in! User",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: constant.primaryColor),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(top: 15, left: 12, right: 12, bottom: 5),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4),
                decoration: BoxDecoration(
                    color: constant.lightBgColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "GMail",
                      style:
                          TextStyle(fontSize: 18, color: constant.primaryColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(  borderRadius: BorderRadius.circular(17)),
                          hintText: "Enter the email",
                          prefixIcon: Icon(Icons.email)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 18, color: constant.primaryColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(  borderRadius: BorderRadius.circular(17)),
                          hintText: "Enter the password",
                          prefixIcon: Icon(Icons.lock)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => ForgetPassU()));
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                                fontSize: 16,
                                color: constant.primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 44,
                    ),
                    InkWell(
                      onTap: () {
                        // validateSignInForm();
                        loginUser();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(colors: [
                              constant.bgColor,
                              constant.lightBgColor
                            ])),
                        child: Center(
                            child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: constant.primaryColor),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have a account?",
                          style: TextStyle(
                              fontSize: 16, color: constant.primaryColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => RegisterAuth()));
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 20,
                                color: constant.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
