import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app_admin/constant/splash.dart';
import 'package:job_search_app_admin/services/database.dart';
import 'package:job_search_app_admin/views/admin/receive_application.dart';
import 'package:job_search_app_admin/views/user/home_view.dart';
import 'package:job_search_app_admin/widget/ASM.dart';
import 'package:job_search_app_admin/widget/constant.dart';
import 'package:random_string/random_string.dart';

class HomeViewAdmin extends StatefulWidget {
  const HomeViewAdmin({super.key});

  @override
  State<HomeViewAdmin> createState() => _HomeViewAdminState();
}

class _HomeViewAdminState extends State<HomeViewAdmin> {
  final CollectionReference job = FirebaseFirestore.instance.collection("jobs");
  var titleControl = TextEditingController();
  var PositionControl = TextEditingController();
  final Asm ASM = Asm();
  var desControl = TextEditingController();

  final Constant constant = Constant();

  Stream? jobStream;
  gettheLoad() async {
    jobStream = await DataBaseMethodA().getJob();
    setState(() {});
  }

  @override
  void initState() {
    gettheLoad();
    // TODO: implement initState
    super.initState();
  }

  Future<void> create() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return myDialogBox(
              context: context,
              title: "Create Job",
              condition: "Create",
              onPressed: () async {
                String title = titleControl.text;
                String descr = titleControl.text;
                String posit = titleControl.text;

                String id = randomAlphaNumeric(10);

                Map<String, dynamic> jobInfoMap = {
                  'id': id,
                  'title': titleControl.text.trim(),
                  'position': PositionControl.text.trim(),
                  'description': desControl.text.trim(),
                };
                await DataBaseMethodA().addJob(jobInfoMap);

                Navigator.pop(context);
                ASM.showSnackBarmsg("Job Created Successfully", context);
                titleControl.clear();
                PositionControl.clear();
                desControl.clear();

                Navigator.pop(context);
              });
        });
  }

  // update function

  Future<void> update(String id, DocumentSnapshot document) async {
    titleControl.text = document['title'];
    PositionControl.text = document['position'];
    desControl.text = document['description'];
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return myDialogBox(
          context: context,
          title: "Update job",
          condition: "Update",
          onPressed: () async {
            String title = titleControl.text.trim();
            String descr = desControl.text.trim();
            String posit = PositionControl.text.trim();

            Map<String, dynamic> jobUpdateMap = {
              'title': title,
              'position': posit,
              'description': descr,
            };
            await DataBaseMethodA().uppdateJob(id, jobUpdateMap);
            ASM.showSnackBarmsg("Job Updated Successfully", context);

            titleControl.clear();
            PositionControl.clear();
            desControl.clear();

            Navigator.pop(context);
          },
        );
      },
    );
  }

  var SearchControl = TextEditingController();
  bool isClickS = false;
  String searchText = "";
  void onChange(String val) {
    setState(() {
      searchText = val;
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
                    MaterialPageRoute(builder: (c) => ReceiveApplication()));
              },
              leading: Icon(Icons.notification_add),
              title: Text("User Application "),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => HomeView()));
              },
              leading: Icon(Icons.home),
              title: Text("Users Home"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: isClickS
            ? Container(
                padding: EdgeInsets.only(left: 15, top: 2, bottom: 5),
                height: 44,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 42, 73, 6),
                    borderRadius: BorderRadius.circular(18)),
                child: TextField(
                  controller: SearchControl,
                  onChanged: onChange,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(3),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                      border: InputBorder.none),
                ),
              )
            : Visibility(
                child: Text(
                "Jobs",
                style: TextStyle(
                    color: constant.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              )),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isClickS = !isClickS;
                });
              },
              icon: Icon(isClickS ? Icons.close : Icons.search)),
          // InkWell(
          //     onTap: () {
          //       Navigator.push(
          //           context, MaterialPageRoute(builder: (c) => HomeView()));
          //     },
          //     child: Icon(Icons.person)),
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
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: List.filled(2, 0),
                                    colors: [
                                      constant.bgColor,
                                      constant.secondaryColor
                                    ])),
                            child: ListTile(
                                title: Text(
                                  ds['title'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                subtitle: Text(
                                  ds['position'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await DataBaseMethodA()
                                                .deleteJob(ds.id);
                                            ASM.showSnackBarmsg(
                                                "Job Deleted Successfully",
                                                context);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 32,
                                          )),
                                      IconButton(
                                          onPressed: () => update(ds.id, ds),
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 31,
                                          )),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: constant.primaryColor,
        onPressed: create,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  myDialogBox(
      {required BuildContext context,
      required String title,
      required String condition,
      required VoidCallback onPressed}) {
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
                  title,
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
              controller: titleControl,
              decoration: InputDecoration(
                  hintText: "Enter Title",
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
              maxLength: 2000,
              maxLines: 3,
              controller: desControl,
              decoration: InputDecoration(
                  hintText: "Enter Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14))),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(
                condition,
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
