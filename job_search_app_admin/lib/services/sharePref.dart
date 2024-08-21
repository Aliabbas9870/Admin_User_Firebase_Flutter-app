import 'package:shared_preferences/shared_preferences.dart';

class sharePref {
  static String userIdKey = "IdKey";
  static String userNameKey = "NameKey";
  static String userEmailKey = "EmailKey";
  static String userPhoneKey = "PhoneKey";
  static String userImageKey = "ImageKey";

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserPhone(String getUserPhone) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userPhoneKey, getUserPhone);
  }

  Future<bool> saveUserImage(String getUserImage) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userImageKey, getUserImage);
  }

  Future<String?> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userIdKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }

  Future<String?> getUserPhone() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userPhoneKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }

  Future<String?> getUserImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userImageKey);
  }
}

// admin data

class sharePrefAdmin {
  static String userIdKey = "IdKey";
  static String userNameKey = "NameKey";
  static String userEmailKey = "EmailKey";
  static String userPhoneKey = "PhoneKey";
  

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserPhone(String getUserPhone) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userPhoneKey, getUserPhone);
  }



  Future<String?> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userIdKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }

  Future<String?> getUserPhone() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userPhoneKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }


}
