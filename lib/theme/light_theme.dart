import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/const_color.dart';

ThemeData light = ThemeData(
  // textTheme: TextTheme(
  //
  //
  //   bodyLarge: TextStyle(
  //     fontSize: 13.sp,
  //     fontFamily: 'Cairo',
  //     color: blackColor,
  //     fontWeight: FontWeight.normal,
  //   ),
  //
  // ),
  fontFamily: 'Cairo-regular',
  primaryColor: Color(0xff25cad2),
  secondaryHeaderColor: Color(0xff25cad2),
  disabledColor: Color(0xFFBABFC4),
  backgroundColor: Color(0xFFF3F3F3),
  errorColor: Color(0xFFE84D4F),
  splashColor: Color(0xFFEFF5F8),
  brightness: Brightness.light,
  hintColor: Color(0xffa8a8a8),
  cardColor: whiteColor,
  colorScheme: ColorScheme.light(
      primary: Color(0xff25cad2), secondary: Color(0xff25cad2)),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Color(0xff25cad2))),
);
