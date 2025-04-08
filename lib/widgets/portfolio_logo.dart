import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';

class PortfolioLogo extends StatelessWidget {
  final VoidCallback? onTap;
  const PortfolioLogo({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        "MK",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          color: CustomColor.yellowSecondary,
        ),
      ),
    );
  }
}
