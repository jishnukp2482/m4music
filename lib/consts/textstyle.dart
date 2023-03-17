import 'package:flutter/material.dart';
import 'package:m4music/consts/colors.dart';

const bold = "bold";
const regular = "regualr";
ourstyle({
  family = "regular",
  double? size = 14,
  Color = whitecolor,
}) {
  return TextStyle(
    fontFamily: family,
    color: Color,
    fontSize: size,
  );
}
