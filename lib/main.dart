import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m4music/views/Homepage.dart';
import 'package:m4music/views/splash.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M 4 MUSIC',
      theme: ThemeData(
       fontFamily: "regualr",
       appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
       )
      ),
      home: Splash(),
    );
  }
}
