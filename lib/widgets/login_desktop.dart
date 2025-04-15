import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';

import 'package:portfolio/widgets/custom_text_field.dart';

class LoginDesktop extends StatelessWidget {
  const LoginDesktop({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: screenHeight / 2),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: CustomColor.bgLight1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: CustomColor.whitePrimary,
              ),
            ),
            const SizedBox(height: 50),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Column(children: [buildNameAndEmailDesktop()]),
            ),
          ],
        ),
      ),
    );
  }

  Column buildNameAndEmailDesktop() {
    return Column(
      children: [
        CustomTextField(hintText: 'Email', controller: emailController),
        SizedBox(height: 15),
        CustomTextField(hintText: 'Password', controller: passwordController),
      ],
    );
  }
}
