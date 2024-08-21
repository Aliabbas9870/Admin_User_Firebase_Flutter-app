import 'package:flutter/material.dart';

class Asm{
  showSnackBarmsg(String msg,BuildContext ctx){
    var snackBar=SnackBar(content: Text(msg));
    

    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  }
}