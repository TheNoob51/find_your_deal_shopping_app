// ignore_for_file: unused_import, implementation_imports, unnecessary_import, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fyd_shopping_app/consts/colors.dart';
import 'package:fyd_shopping_app/consts/consts.dart';
import 'package:fyd_shopping_app/views/auth_screen/login_screen.dart';
import 'package:fyd_shopping_app/views/home_screen/home.dart';
import 'package:get/get.dart';

import '../widgets_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //creating the method to change screen
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      //using getX
      //Get.to(() => const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

//we still need to add the image background in it using decoration tag in body, but its showing error
//check again after sometime
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: golden,
        body: DecoratedBox(
      // BoxDecoration takes the image
      decoration: BoxDecoration(
        // Image set to background of the body
        image: DecorationImage(
            image: AssetImage(imgBackground), fit: BoxFit.cover),
      ),
      child: Center(
          child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300)),
          20.heightBox,

          credits.text.fontFamily(ti).size(28).black.make(),
          5.heightBox,
          subline1.text.black.make(),
          5.heightBox,
          subline2.text.black.make(),
          Spacer(),
          appversion.text.black.fontFamily(semibold).make(),
          30.heightBox,
          //completed splash screen
        ],
      )),
    ));
  }
}
