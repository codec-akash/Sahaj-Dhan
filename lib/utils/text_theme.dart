import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextUtil {
  static TextStyle headingText = TextStyle(
    fontSize: 32.h,
    height: 40.h / 32.h,
  );

  static TextStyle headingTitleText = TextStyle(
    fontSize: 24.h,
    height: 32.h / 24.h,
  );

  static TextStyle titleText = TextStyle(
    fontSize: 16.h,
    height: 24.h / 16.h,
  );

  static TextStyle titleTextBold = TextStyle(
    fontSize: 16.h,
    height: 24.h / 16.h,
    fontWeight: FontWeight.w600,
  );

  static TextStyle text14 = TextStyle(
    fontSize: 14.h,
    height: 22.h / 14.h,
  );

  static TextStyle text14Bold = TextStyle(
    fontSize: 14.h,
    height: 22.h / 14.h,
    fontWeight: FontWeight.w600,
  );

  static TextStyle subTitleText = TextStyle(
    fontSize: 12.h,
    height: 24.h / 16.h,
  );

  static TextStyle subTitleTextBold = TextStyle(
    fontSize: 12.h,
    height: 24.h / 16.h,
    fontWeight: FontWeight.w600,
  );
}
