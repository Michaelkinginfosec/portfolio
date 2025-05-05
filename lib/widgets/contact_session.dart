import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/contact/contact_bloc.dart';
import 'package:portfolio/bloc/contact/contact_event.dart';
import 'package:portfolio/bloc/contact/contact_state.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/size.dart';
import 'package:portfolio/constants/social_linkes.dart';
import 'package:portfolio/datasource/models/contact_model.dart';
import 'package:portfolio/widgets/custom_text_field.dart';

@JS('window.open')
external JSAny? openWindow(JSString url, JSString target);

void openLink(String url) {
  openWindow(url.toJS, '_blank'.toJS);
}

class ContactSession extends StatefulWidget {
  const ContactSession({super.key});

  @override
  State<ContactSession> createState() => _ContactSessionState();
}

class _ContactSessionState extends State<ContactSession> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is ContactLoading) {
          Center(
            child: CircularProgressIndicator(
              backgroundColor: CustomColor.yellowPrimary,
            ),
          );
        } else if (state is ContactSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          nameController.clear();
          emailController.clear();
          messageController.clear();
        } else if (state is ContactFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
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
                constraints: const BoxConstraints(
                  maxWidth: 700,
                  maxHeight: 100,
                ),
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
                child: CustomTextField(
                  hintText: 'Your message',
                  maxLine: 16,
                  controller: messageController,
                ),
              ),
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
                    onPressed: () {
                      final name = nameController.text.trim();
                      final email = emailController.text.trim();
                      final message = messageController.text.trim();

                      if (name.isEmpty || email.isEmpty || message.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields'),
                          ),
                        );
                        return;
                      }

                      final contactModel = ContactModel(
                        name: name,
                        email: email,
                        message: message,
                      );

                      context.read<ContactBloc>().add(
                        ContactMeEvent(contactModel),
                      );
                    },
                    child:
                        state is ContactLoading
                            ? const CircularProgressIndicator(
                              color: CustomColor.whitePrimary,
                            )
                            : const Text(
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
                    onTap: () => openLink(SocialLinkes.github),
                    child: Image.asset('assets/images/github.png', width: 28),
                  ),
                  InkWell(
                    onTap: () => openLink(SocialLinkes.linkedIn),
                    child: Image.asset('assets/images/linkedin.png', width: 28),
                  ),
                  InkWell(
                    onTap: () => openLink(SocialLinkes.facebook),
                    child: Image.asset('assets/images/facebook.png', width: 28),
                  ),
                  InkWell(
                    onTap: () => openLink(SocialLinkes.instagram),
                    child: Image.asset(
                      'assets/images/instagram.png',
                      width: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Row buildNameAndEmailDesktop() {
    return Row(
      children: [
        Flexible(
          child: CustomTextField(
            hintText: 'Your name',
            controller: nameController,
          ),
        ),
        SizedBox(width: 15),
        Flexible(
          child: CustomTextField(
            hintText: 'Your email',
            controller: emailController,
          ),
        ),
      ],
    );
  }

  Column buildNameAndEmailMobile() {
    return Column(
      children: [
        Flexible(
          child: CustomTextField(
            hintText: 'Your name',
            controller: nameController,
          ),
        ),
        SizedBox(height: 15),
        Flexible(
          child: CustomTextField(
            hintText: 'Your email',
            controller: emailController,
          ),
        ),
      ],
    );
  }
}
