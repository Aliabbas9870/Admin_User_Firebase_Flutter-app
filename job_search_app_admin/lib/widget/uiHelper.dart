import 'package:flutter/material.dart';

class UiHelper {
  static CustomTextField(TextEditingController controller, String text,
      IconData icondata, bool toHide) {
    return TextField(
      controller: controller,
      obscureText: toHide,
      decoration: InputDecoration(
          hintText: text,
          suffixIcon: Icon(icondata),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

  static CustomButton(VoidCallback voidCallback, String text) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
          onPressed: () {
            voidCallback();
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          )),
    );
  }

  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }
}