import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethod {
  Future adduserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addAdminDetail(Map<String, dynamic> adminInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Admins")
        .doc(id)
        .set(adminInfoMap);
  }
}



// apply job  dAATA 


class DataBaseMethodApply {
// add data
  Future addApply(Map<String, dynamic> addApplicationMap) async {
    return await FirebaseFirestore.instance.collection("application").add(addApplicationMap);
  }

  // show for
  // Future<Stream<QuerySnapshot>> getApply() async {
  //   return await FirebaseFirestore.instance.collection("application").snapshots();
  // }

  Future<Stream<QuerySnapshot>> getJob() async {
    return await FirebaseFirestore.instance.collection("application").snapshots();
  }
// delete
  Future deleteApply(
    String id,
  ) async {
    return await FirebaseFirestore.instance.collection("application").doc(id).delete();
    // return await FirebaseFirestore.instance.collection("application").doc(id).delete();
  }

  //update

  Future uppdateApply(String id, Map<String, dynamic> updateMap) async {
    
    return await FirebaseFirestore.instance
        .collection("application")
        .doc(id)
        .update(updateMap);
  }
}

/// job data 

class DataBaseMethodA {
// add data
  Future addJob(Map<String, dynamic> addJobMap) async {
    return await FirebaseFirestore.instance.collection("jobs").add(addJobMap);
  }

  // show for
  Future<Stream<QuerySnapshot>> getJob() async {
    return await FirebaseFirestore.instance.collection("jobs").snapshots();
  }

// delete
  Future deleteJob(
    String id,
  ) async {
    return await FirebaseFirestore.instance.collection("jobs").doc(id).delete();
  }

  //update

  Future uppdateJob(String id, Map<String, dynamic> updateMap) async {
    return await FirebaseFirestore.instance
        .collection("jobs")
        .doc(id)
        .update(updateMap);
  }
}

class DatabaseTodo {
  Future addTodoDay(Map<String, dynamic> addTodoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Today")
        .doc(id)
        .set(addTodoMap);
  }

  Future addTodoTomorrow(Map<String, dynamic> addTodoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Tomorrow")
        .doc(id)
        .set(addTodoMap);
  }

//add data
  Future addTodoWeek(Map<String, dynamic> addTodoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("NextWeek")
        .doc(id)
        .set(addTodoMap);
  }

  // gett data///
  Future<Stream<QuerySnapshot>> getAllWorkTodo(String today) async {
    return await FirebaseFirestore.instance.collection(today).snapshots();
  }

  updateClick(String id, String day) async {
    return await FirebaseFirestore.instance
        .collection(day)
        .doc(id)
        .update({"yes": true});
  }

// delete
  Future deleteTodo(String id, String today) async {
    return await FirebaseFirestore.instance.collection(today).doc(id).delete();
  }

// delete code

  // await DatabaseTodo().deleteTodo(
  //     ds.id,
  //     today
  //         ? "Today"
  //         : tomorrow
  //             ? "Tomorrow"
  //             : "NextWeek");
}
