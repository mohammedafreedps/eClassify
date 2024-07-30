import 'package:eClassify/core/theme/pallete.dart';
import 'package:flutter/material.dart';


class AppTheme {
  static var lightModeAppTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Pallete.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Pallete.blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Pallete.whiteColor,
    ),
    primaryColor: Pallete.blackColor,
  );
}
