// ignore_for_file: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:payment_demo/core/feature_injection.dart';
import 'bloc/login_cubit.dart';
import 'bloc/login_state.dart';
import 'widgets/user_text_field.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocProvider(
        create: (_) => injector<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listenWhen: (_, state) => state is LoginToastErrorState,
          listener: (context, state) {
            switch (state) {
              case LoginToastErrorState():
                toastification.show(
                  type: ToastificationType.error,
                  context: context, // optional if you use ToastificationWrapper
                  title: Text(state.error),
                  autoCloseDuration: const Duration(seconds: 2),
                );
              default:
            }
          },
          builder: (context, state) => _getLoginComponent(context, state),
        ),
      ),
    );
  }

  Widget _getLoginComponent(BuildContext context, LoginState state) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Colors.orange.shade900,
        Colors.orange.shade800,
        Colors.orange.shade400
      ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    )),
                const SizedBox(
                  height: 10,
                ),
                FadeInUp(
                    duration: const Duration(milliseconds: 1300),
                    child: const Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 60,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              UserTextField(
                                hint: 'User name',
                                controller: userNameController,
                              ),
                              UserTextField(
                                hint: 'Password',
                                controller: passwordController,
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 80,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          onPressed: () {
                            context.read<LoginCubit>().checkLogin(
                                userNameController.text,
                                passwordController.text);
                          },
                          height: 50,
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
