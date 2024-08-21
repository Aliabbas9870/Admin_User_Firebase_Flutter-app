
import 'package:flutter/material.dart';
import 'package:job_search_app_admin/widget/constant.dart';


class LoadingDialog extends StatelessWidget {
  String textMessage;
  LoadingDialog({super.key, required this.textMessage});
  final Constant constant = Constant();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: constant.lightBgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        margin: EdgeInsets.all(14),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(constant.primaryColor),
              ),
              SizedBox(
                width: 13,
              ),
              Text(
                textMessage,
                style: TextStyle(color: constant.primaryColor, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
