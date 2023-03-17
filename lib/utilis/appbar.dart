import 'package:flutter/material.dart';
import 'package:m4music/consts/colors.dart';
import 'package:m4music/consts/textstyle.dart';
AppBar appBar() {
  return AppBar(
    backgroundColor: bgdarkcolor,
    leading: Icon(Icons.sort_rounded,color: whitecolor,),
    title: Text(
      "M4-MUSIC",
      style: ourstyle(
          family: bold,
          size: 18, 
      ),
    ),
    actions: [
      IconButton(onPressed: (){}, icon:Icon(Icons.search,color: whitecolor,)),
    ],
  );
}
