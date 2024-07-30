import 'package:eClassify/pay/Constants/colors.dart';
import 'package:eClassify/pay/Constants/images.dart';
import 'package:eClassify/pay/Controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenPay extends StatelessWidget {
  SplashScreenPay({Key? key}) : super(key: key);

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 80),
          child: Image.asset(Images.splashImage),
        ),
      ),
    );
  }
}
