import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app_admin/auth/admin/admin_login.dart';
import 'package:job_search_app_admin/auth/user/login_auth.dart';
import 'package:job_search_app_admin/services/database.dart';
import 'package:job_search_app_admin/services/sharePref.dart';
import 'package:job_search_app_admin/views/admin/home_view_admin.dart';
import 'package:job_search_app_admin/views/user/home_view.dart';
import 'package:job_search_app_admin/widget/ASM.dart';
import 'package:job_search_app_admin/widget/constant.dart';
import 'package:job_search_app_admin/widget/loading.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:random_string/random_string.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({super.key});

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  final Constant constant = Constant();

  
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final Asm ASM = Asm();
  validateSignUpForm() {
    if (nameController.text.trim().length < 3) {
      ASM.showSnackBarmsg("Name Character must be at least 3 or more", context);
    } else if (phoneController.text.trim().length < 8) {
      ASM.showSnackBarmsg(
          "Phone number  must be at least 8 or more numbers", context);
    } else if (!emailController.text.contains("@")) {
      ASM.showSnackBarmsg("Email not valid", context);
    } else if (passwordController.text.trim().length < 5) {
      ASM.showSnackBarmsg("Password must be at least 5 or more", context);
    } else {
      signupUserNow();
    }
  }

  signupUserNow() async {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            LoadingDialog(textMessage: "Please wait....."));
    try {
      final User? firebaseuser = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim())
              .catchError((c) {
        Navigator.pop(context);
        ASM.showSnackBarmsg(c.toString(), context);
      }))
          .user;

      // save local data also  sghare

// also store data base
      String id = randomAlphaNumeric(10);
      // await sharePref().saveUserId(id);
      // await sharePref().saveUserEmail(emailController.text);
      // await sharePref().saveUserPhone(phoneController.text);
      // await sharePref().saveUserName(nameController.text);

      Map<String, dynamic> adminInfoMap = {
        'id': id,
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'blockStatus': "no"
      };
      await DataBaseMethod().addAdminDetail(adminInfoMap, id);
// data add both place
// real database store
      // Map userDataMap = {
      //   'name': nameController.text.trim(),
      //   'phone': phoneController.text.trim(),
      //   'email': emailController.text.trim(),
      //   'password': passwordController.text.trim(),
      //   'id': id,
      //   'blockStatus': "no"
      // };
      // FirebaseDatabase.instance
      //     .ref()
      //     .child("users")
      //     .child(firebaseuser!.uid)
      //     .set(userDataMap);
      // Navigator.pop(context);
      ASM.showSnackBarmsg("Account created successfully!", context);
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => HomeViewAdmin()));
      QuickAlert.show(
        context: context,
  
        type: QuickAlertType.success,
        text: 'Account Created Successfully!',
      );
    } on FirebaseAuthException catch (e) {
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      ASM.showSnackBarmsg(e.toString(), context);
    }
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
                  "Create Your\nAccount as a Admin",
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
                    top: MediaQuery.of(context).size.height / 5),
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
                      "Full Name",
                      style:
                          TextStyle(fontSize: 18, color: constant.primaryColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17)),
                          hintText: "Enter the full name",
                          prefixIcon: Icon(Icons.person)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Phone Number",
                      style:
                          TextStyle(fontSize: 18, color: constant.primaryColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17)),
                          hintText: "Enter the Phone",
                          prefixIcon: Icon(Icons.phone)),
                    ),
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17)),
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17)),
                          hintText: "Enter the password",
                          prefixIcon: Icon(Icons.lock)),
                    ),
                    SizedBox(
                      height: 44,
                    ),
                    InkWell(
                      onTap: () {
                        validateSignUpForm();
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
                          "Create Account",
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
                          "Already have a account!",
                          style: TextStyle(
                              fontSize: 16, color: constant.primaryColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => AdminLogin()));
                          },
                          child: Text(
                            "sign in",
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
