import 'package:flutter/material.dart';
import 'package:sahaj_dhan/core/widgets/button.dart';

class TopInvestorButton extends StatelessWidget {
  final VoidCallback onTap;
  const TopInvestorButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Button(
      onTap: onTap,
      title: "Check Top Investors",
    );
  }
}
