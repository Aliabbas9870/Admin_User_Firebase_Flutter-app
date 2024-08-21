import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_search_app_admin/services/database.dart';
import 'package:job_search_app_admin/views/user/home_view.dart';
import 'package:job_search_app_admin/widget/ASM.dart';
import 'package:job_search_app_admin/widget/constant.dart';
import 'package:random_string/random_string.dart';

class ReceiveApplication extends StatefulWidget {
  const ReceiveApplication({super.key});

  @override
  State<ReceiveApplication> createState() => _ReceiveApplicationState();
}

class _ReceiveApplicationState extends State<ReceiveApplication> {
  @override
  final CollectionReference apply =
      FirebaseFirestore.instance.collection("application");
  var titleControl = TextEditingController();
  var PositionControl = TextEditingController();
  final Asm ASM = Asm();
  var desControl = TextEditingController();

  final Constant constant = Constant();

  Stream? applyStream;
  gettheLoad() async {
    applyStream = await DataBaseMethodApply().getJob();
    setState(() {});
  }

  @override
  void initState() {
    gettheLoad();
    // TODO: implement initState
    super.initState();
  }

  // update function

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
                "Applications",
                style: TextStyle(
                    color: constant.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              )),
        actions: [
          // InkWell(
          //     onTap: () {
          //       Navigator.push(
          //           context, MaterialPageRoute(builder: (c) => HomeView()));
          //     },
          //     child: Icon(Icons.person)),

          //     Padding(
          // padding: const EdgeInsets.all(8.0),
          // child: InkWell (
          //   onTap: (){
          //     FirebaseAuth.instance.signOut();
          //     Navigator.push(context, MaterialPageRoute(builder: (c)=>Splash()));
          //   },
          //   child: Icon(Icons.logout)),)
        ],
      ),
      backgroundColor: constant.lightBgColor,
      body: ListView(
        
        children: [
        
          AllData(applyStream: applyStream, constant: constant, ASM: ASM),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: constant.primaryColor,
      //   onPressed: create,
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}

class AllData extends StatelessWidget {
  const AllData({
    super.key,
    required this.applyStream,
    required this.constant,
    required this.ASM,
  });

  final Stream? applyStream;
  final Constant constant;
  final Asm ASM;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: applyStream,
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
                              leading: Icon(
                                Icons.person,
                                size: 23,
                                color: Colors.white,
                              ),
                              title: Text(
                                 ds['name'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              subtitle: Text(
                                "" + ds['position'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await DataBaseMethodApply()
                                              .deleteApply(ds.id);
                                          ASM.showSnackBarmsg(
                                              "Application Deleted Successfully",
                                              context);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 32,
                                        )),
                                    // IconButton(
                                    //     // onPressed: () => update(ds.id, ds),
                                    //     icon: Icon(
                                    //       Icons.edit,
                                    //       color: Colors.white,
                                    //       size: 31,
                                    //     )),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(color: Colors.black,),
                );
        });
  }
}
