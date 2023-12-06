import 'package:boopbook/core/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_constant.dart';


ThemeData getApplicationLightTheme(context) {
  return ThemeData(
    scaffoldBackgroundColor: ColorConstant.whiteA700,
    // app bar theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: true,
      backgroundColor: ColorConstant.whiteA700,
      iconTheme:  IconThemeData(
        color: ColorConstant.black900,
      ),
      elevation:0,
      titleTextStyle: textStyle(
        context: context,

        fontSize: 14,
        color: ColorConstant.black900,
        // It will be changed
        // color: ColorConstant.black,
      ),
    ),

    sliderTheme:  SliderThemeData(
      valueIndicatorTextStyle: TextStyle(
        color: ColorConstant.whiteA700,
      ),
    ),

    primarySwatch: Colors.grey,
    bottomSheetTheme:  BottomSheetThemeData(
      backgroundColor: ColorConstant.whiteA700,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorConstant.black900,
        textStyle: textStyle(
          context: context,
          color: ColorConstant.black900,
          fontSize: 18,
        ),
      ),
    ),

    cardColor: ColorConstant.whiteA700,

    iconTheme:  IconThemeData(
      color: ColorConstant.black900,
    ),

    listTileTheme:  ListTileThemeData(
      iconColor: ColorConstant.black900,
      textColor: ColorConstant.black900,
    ),

    drawerTheme:  DrawerThemeData(
      backgroundColor: ColorConstant.whiteA700,
    ),
    //BottomNavigationBarTheme
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      selectedItemColor: ColorConstant.redA400,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: ColorConstant.whiteA700,
      selectedLabelStyle: TextStyle(color: Colors.teal),
      unselectedItemColor: ColorConstant.gray20005,
      unselectedLabelStyle: TextStyle(
        color: ColorConstant.gray20005,
      ),
      type: BottomNavigationBarType.fixed,
    ),

    // _______/ It will be updated \_________________________
    textTheme: TextTheme(
      titleLarge: textStyle(
        context: context,
        fontSize: 22,
        color: ColorConstant.black900,
      ),
      titleMedium: textStyle(
        context: context,
        fontSize: 18,
        color: ColorConstant.black900,
      ),
      titleSmall: textStyle(
        context: context,
        color: ColorConstant.black900,
        fontSize: 16,
      ),
      displayMedium: textStyle(
        context: context,
        color: ColorConstant.black900,
        fontSize: 18,
      ),
      displaySmall: textStyle(
        context: context,
        color: ColorConstant.gray20005,
        fontSize: 14,
      ),
      bodyMedium: textStyle(
        context: context,
        color: ColorConstant.black900,
        fontSize: 18,
      ),
      bodySmall: textStyle(
        context: context,
        color: ColorConstant.gray20005,
        fontSize: 16,
      ),
      headlineLarge: textStyle(
        context: context,
        color: ColorConstant.black900,
        fontSize: 30,
      ),
      headlineSmall: textStyle(
        context: context,
        color: ColorConstant.black900,
        fontSize: 25,
      ),
    ),
    // input decoration theme (text form field)
  );
}

ThemeData getApplicationDarkTheme(context) {
  return ThemeData(
    scaffoldBackgroundColor: ColorConstant.black900,
    // app bar theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      centerTitle: true,
      backgroundColor: ColorConstant.black900,
      iconTheme:  IconThemeData(color: ColorConstant.whiteA700),
      elevation: 0,
      titleTextStyle: textStyle(
        context: context,

        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ColorConstant.whiteA700, // It will be changed
        // color: ColorConstant.white,
      ),
    ),

    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      selectedItemColor: CupertinoColors.activeBlue,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: ColorConstant.black900,
      selectedLabelStyle: TextStyle(color: Colors.grey),
      unselectedItemColor: ColorConstant.gray20005,
      unselectedLabelStyle: TextStyle(color: ColorConstant.gray20005),
      type: BottomNavigationBarType.fixed,
    ),

    primarySwatch: Colors.red,
    bottomSheetTheme:  BottomSheetThemeData(
      backgroundColor: ColorConstant.black900,
      elevation: 3,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorConstant.whiteA700,
        textStyle: textStyle(
          color: ColorConstant.whiteA700,
          fontSize: 18,
          context: context,
        ),
      ),
    ),

    sliderTheme:  SliderThemeData(
      valueIndicatorTextStyle: TextStyle(
        color: ColorConstant.whiteA700,
      ),
    ),

    cardColor: ColorConstant.black900,

    listTileTheme:  ListTileThemeData(
      iconColor: ColorConstant.whiteA700,
      textColor: ColorConstant.whiteA700,
    ),

    drawerTheme: DrawerThemeData(
      backgroundColor: ColorConstant.black900,
    ),

    iconTheme: IconThemeData(
      color: ColorConstant.whiteA700,
    ),

    textTheme: TextTheme(
      titleLarge: textStyle(
        context: context,
        fontSize: 22,
        color: ColorConstant.whiteA700,
      ),
      titleMedium: textStyle(
        context: context,
        fontSize: 18,
        color: ColorConstant.whiteA700,
      ),
      titleSmall: textStyle(
        context: context,
        color: ColorConstant.whiteA700,
        fontSize: 16,
      ),
      displayMedium: textStyle(
        context: context,
        color: ColorConstant.whiteA700,
        fontSize: 18,
      ),
      displaySmall: textStyle(
        context: context,
        color: ColorConstant.whiteA700,
        fontSize: 14,
      ),
      bodyMedium: textStyle(
        context: context,
        color: ColorConstant.whiteA700,
        fontSize: 18,
      ),
      bodySmall: textStyle(
        context: context,
        color: ColorConstant.whiteA700,
        fontSize: 16,
      ),
      headlineLarge: textStyle(
        context: context,
        color: ColorConstant.whiteA700,
        fontSize: 30,
      ),
      headlineSmall: textStyle(
        context: context,
        color: ColorConstant.whiteA700,
        fontSize: 25,
      ),
    ),
  );
}
