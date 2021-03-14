import 'package:flutter/material.dart';
List <BoxShadow>blackshadow=[
  BoxShadow(
      color: Colors.black.withOpacity(0.15),
      spreadRadius: 0,
      offset: Offset(0, 4.51),
      blurRadius: 16.9
  ),

];

Color kblue = Color(0xff2972ff);
Color klightBlue = Color(0xff85a0ff);
Color kgrey =Color(0xff3e4958);

final InputDecoration decoration = new InputDecoration(
  focusedBorder: new OutlineInputBorder(
    borderSide: BorderSide(color: kblue),
  ),
  labelStyle: TextStyle(color: Colors.black),
  hintText: "Name",
  labelText: "Name",
);