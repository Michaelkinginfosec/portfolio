import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/bloc/auth/auth_bloc.dart';
import 'package:portfolio/bloc/auth/auth_event.dart';
import 'package:portfolio/bloc/auth/auth_state.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/size.dart';
import 'package:portfolio/widgets/login_desktop.dart';
import 'package:portfolio/widgets/login_mobile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: CustomColor.scaffoldBg,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'WELCOME MICHAELKING',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: CustomColor.whitePrimary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  constraints.maxWidth > kMinDesktopWidth
                      ? LoginDesktop(
                        emailController: emailController,
                        passwordController: passwordController,
                      )
                      : LoginMobile(
                        emailController: emailController,
                        passwordController: passwordController,
                      ),

                  const SizedBox(height: 40),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          constraints.maxWidth > kMinDesktopWidth ? 500 : 450,
                    ),
                    child: BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: CustomColor.yellowPrimary,
                            ),
                          );
                          // context.read<LoginBloc>().add(CheckAuthStatus());

                          context.go('/dashboard');
                        } else if (state is LoginFailed) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(state.error)));
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: CustomColor.yellowPrimary,
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();

                            if (email.isNotEmpty && password.isNotEmpty) {
                              context.read<LoginBloc>().add(
                                LoginRequested(email, password),
                              );
                            }
                            // if (_formKey.currentState!.validate()) {

                            // }
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: CustomColor.yellowPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.whitePrimary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
