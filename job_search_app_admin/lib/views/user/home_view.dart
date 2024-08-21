import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app_admin/constant/splash.dart';
import 'package:job_search_app_admin/services/database.dart';
import 'package:job_search_app_admin/views/admin/home_view_admin.dart';
import 'package:job_search_app_admin/widget/ASM.dart';
import 'package:job_search_app_admin/widget/constant.dart';
import 'package:random_string/random_string.dart';
import 'package:rich_readmore/rich_readmore.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final CollectionReference job = FirebaseFirestore.instance.collection("jobs");
  var titleControl = TextEditingController();
  var PositionControl = TextEditingController();
  var desControl = TextEditingController();
  var phoneControl = TextEditingController();
  var expeControl = TextEditingController();
  var nameController = TextEditingController();
  final Constant constant = Constant();

  Stream? jobStream;
  gettheLoad() async {
    jobStream = await DataBaseMethodA().getJob();
    setState(() {});
  }

  final Asm ASM = Asm();

  @override
  void initState() {
    gettheLoad();
    // TODO: implement initState
    super.initState();
  }

  Future<void> createApplication() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return myDialogBox();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: ListTile()),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => HomeViewAdmin()));
              },
              leading: Icon(Icons.notification_add),
              title: Text("Admin Panel"),
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (c) => HomeView()));
            //   },
            //   leading: Icon(Icons.home),
            //   title: Text(""),
            // ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Visibility(child: Text("Jobs")),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: constant.primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => Splash()));
                },
                child: Icon(Icons.logout)),
          )
        ],
      ),
      body: StreamBuilder(
          stream: jobStream,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              width: MediaQuery.of(context).size.width - 30,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: constant.secondaryColor,
                                borderRadius: BorderRadius.circular(25),
                              ),

                              // title: Text(ds['title'],style: TextStyle(color: constant.lightBgColor,fontSize: 20),),
                              // subtitle: Text(ds['position']),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(ds["title"],
                                          style: TextStyle(
                                              color: constant.lightBgColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28)),
                                    ),
                                    Text("Position :    " + ds["position"],
                                        style: TextStyle(
                                            color: constant.lightBgColor,
                                            fontSize: 23)),
                                    RichReadMoreText(
                                      TextSpan(
                                          text: "Description :    " +
                                              ds["description"],
                                          style: TextStyle(
                                              color: constant.lightBgColor,
                                              fontSize: 21)),
                                      settings: LineModeSettings(
                                        trimLines: 2,
                                        trimCollapsedText: '...Read More',
                                        trimExpandedText: ' Show less',
                                        lessStyle: TextStyle(
                                            color: constant.primaryColor,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                        moreStyle: TextStyle(
                                            color: constant.primaryColor,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                        onPressReadMore: () {},
                                        onPressReadLess: () {
                                          /// specific method to be called on press to show less
                                        },
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: constant.primaryColor),
                                          child: TextButton(
                                              onPressed: () {
                                                createApplication();
                                              },
                                              child: Text("Apply",
                                                  style: TextStyle(
                                                      color:
                                                          constant.lightBgColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 23))),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }

  myDialogBox() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  "Fill the form",
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Enter name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14))),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: PositionControl,
              decoration: InputDecoration(
                  hintText: "Position",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14))),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              controller: expeControl,
              decoration: InputDecoration(
                  hintText: "How many year experience",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14))),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              controller: phoneControl,
              decoration: InputDecoration(
                  hintText: "Enter Mobile # ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14))),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String position = PositionControl.text;
                String contact = phoneControl.text;
                String experience = expeControl.text;

                String id = randomAlphaNumeric(10);

                Map<String, dynamic> applyInfoMap = {
                  'id': id,
                  'name': nameController.text.trim(),
                  'position': PositionControl.text.trim(),
                  'experience': expeControl.text.trim(),
                  'contact': phoneControl.text.trim(),
                };
                await DataBaseMethodApply().addApply(applyInfoMap);
                Navigator.pop(context);
                ASM.showSnackBarmsg("Application submit Successfully", context);
                titleControl.clear();
                PositionControl.clear();
                desControl.clear();
                expeControl.clear();
              },
              child: Text(
                "Apply",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: constant.secondaryColor,
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
