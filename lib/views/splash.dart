import 'dart:async';

import 'package:flutter/material.dart';
import 'package:m4music/consts/colors.dart';
import 'package:m4music/consts/textstyle.dart';
import 'package:m4music/views/Homepage.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Get.off(() => homepage());
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                MdiIcons.music,
                color: whitecolor,
                size: 50,
              ),
              Text("M4 Music",
                  style: ourstyle(
                    size: 25,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
