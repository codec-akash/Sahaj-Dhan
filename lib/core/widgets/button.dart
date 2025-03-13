import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';

class Button extends StatelessWidget {
  final Function() onTap;
  final String title;
  const Button({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
        color: Colors.blue,
        child: Text(
          title,
          style: CustomTextTheme.text12.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
