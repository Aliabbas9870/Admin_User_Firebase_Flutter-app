import 'package:flutter/material.dart';
import 'package:job_search_app_admin/widget/constant.dart';

class AssociateMethod {
  final Constant constant = Constant();
  showSnackBarmsg(String msg, BuildContext ctx) {
    var snackBar = SnackBar(
        backgroundColor: constant.lightBgColor,
        content: Text(
          msg,
          style: TextStyle(
              color: constant.primaryColor, fontWeight: FontWeight.bold),
        ));
    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  }
}
