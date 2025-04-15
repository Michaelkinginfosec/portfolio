import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/size.dart';
import 'package:portfolio/constants/social_linkes.dart';
import 'package:portfolio/widgets/custom_text_field.dart';

@JS('window.open')
external JSAny? openWindow(JSString url, JSString target);

void openLink(String url) {
  openWindow(url.toJS, '_blank'.toJS);
}

class ContactSession extends StatelessWidget {
  const ContactSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),

      color: CustomColor.bgLight1,
      child: Column(
        children: [
          const Text(
            'Get in touch',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: CustomColor.whitePrimary,
            ),
          ),
          const SizedBox(height: 50),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700, maxHeight: 100),

            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= kMinDesktopWidth) {
                  return buildNameAndEmailDesktop();
                }
                return buildNameAndEmailMobile();
              },
            ),
          ),
          const SizedBox(height: 15),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: const CustomTextField(hintText: 'Your message', maxLine: 16),
          ),
          //send button
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: SizedBox(
              height: 40,
              width: double.maxFinite,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.yellowPrimary,
                ),
                onPressed: () {},
                child: const Text(
                  'Get in touch',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.whitePrimary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: const Divider(),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  openLink(SocialLinkes.github);
                },
                child: Image.asset('assets/images/github.png', width: 28),
              ),
              InkWell(
                onTap: () {
                  openLink(SocialLinkes.linkedIn);
                },
                child: Image.asset('assets/images/linkedin.png', width: 28),
              ),
              InkWell(
                onTap: () {
                  openLink(SocialLinkes.facebook);
                },
                child: Image.asset('assets/images/facebook.png', width: 28),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset('assets/images/instagram.png', width: 28),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildNameAndEmailDesktop() {
    return const Row(
      children: [
        Flexible(child: CustomTextField(hintText: 'Your name')),
        SizedBox(width: 15),
        Flexible(child: CustomTextField(hintText: 'Your email')),
      ],
    );
  }

  Column buildNameAndEmailMobile() {
    return const Column(
      children: [
        Flexible(child: CustomTextField(hintText: 'Your name')),
        SizedBox(height: 15),
        Flexible(child: CustomTextField(hintText: 'Your email')),
      ],
    );
  }
}
