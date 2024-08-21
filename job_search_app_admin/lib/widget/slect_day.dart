import 'package:flutter/material.dart';
import 'package:job_search_app_admin/widget/constant.dart';

class SlectDay extends StatelessWidget {
  String titel;
  SlectDay({super.key, required this.titel});
  final Todo col = Todo(); // color

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: col.sColor,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
            color: col.sColor, borderRadius: BorderRadius.circular(12)),
        child: Text(
          titel,
          style: TextStyle(
              color: col.tColor, fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
