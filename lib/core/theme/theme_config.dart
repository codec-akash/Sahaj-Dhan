import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData lightTheme({Brightness brightness = Brightness.light}) =>
      ThemeData(brightness: brightness)
          .copyWith(textTheme: GoogleFonts.spaceMonoTextTheme());
}

class CustomTextTheme extends TextStyle {
  static TextStyle text16 = TextStyle(
    fontSize: 16.h,
    height: 20.h / 16.h,
    fontWeight: FontWeight.w400,
  );

  static TextStyle text14 = TextStyle(
    fontSize: 14.h,
    height: 18.h / 14.h,
    fontWeight: FontWeight.w400,
  );

  static TextStyle text12 = TextStyle(
    fontSize: 12.h,
    height: 14.h / 12.h,
    fontWeight: FontWeight.w400,
  );

  static TextStyle text10 = TextStyle(
    fontSize: 10.h,
    height: 14.h / 10.h,
    fontWeight: FontWeight.w400,
  );
}
