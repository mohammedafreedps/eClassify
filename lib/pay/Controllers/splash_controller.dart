import 'dart:async';
import 'package:eClassify/features/tabbar/tabbar_screen.dart';
import 'package:eClassify/pay/Screens/AuthScreens/login_screen.dart';
import 'package:eClassify/pay/Screens/HomeScreen/home_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(
      Duration(seconds: 1),
          () => Get.off(
        TabbarScreen(),
      ),
    );
    super.onInit();
  }
}
