import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app_admin/views/admin/home_view_admin.dart';

class ForgetPassA extends StatefulWidget {
  const ForgetPassA({super.key});

  @override
  State<ForgetPassA> createState() => _ForgetPassAState();
}

class _ForgetPassAState extends State<ForgetPassA> {
  var phoneController = TextEditingController();
  var codeController = TextEditingController();
  String phoneNum = "";
  String smsCode = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  siginWithPhone() async {
    UserCredential credential;
    User user;

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "+92" + phoneNum.trim(),
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            await auth.signInWithCredential(authCredential).then((val) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => HomeViewAdmin()));
            });
          },
          verificationFailed: ((error) {}),
          codeSent: (String verificationId, [int? forceResentToken]) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Enter the OTP"),
                    content: Column(
                      children: [
                        TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          controller: codeController,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              smsCode = codeController.text;
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: smsCode);
                              auth.signInWithCredential(credential).then((val) {
                                if (val != null) {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) => HomeViewAdmin()))
                                      .catchError((e) {
                                    print(e);
                                  });
                                }
                              });
                            },
                            child: Text("Verify"))
                      ],
                    ),
                  );
                });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
          },
          timeout: Duration(seconds: 45));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 80),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    Text("Enter the number s"),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        siginWithPhone();
                      },
                      child: Container(
                        width: 120,
                      decoration: BoxDecoration(
                        
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Send Code")),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
