import 'dart:ui';

import 'package:exercise/pages/sign_in_page/sign_in_page_controller.dart';
import 'package:exercise/pages/sign_up_page/sign_up_page.dart';
import 'package:exercise/widgets/animated_background.dart';
import 'package:exercise/widgets/blurred_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends GetView<SignInController> {
  static String routeName = "/sign_in";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedBackground(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 80),
                    Center(
                      child: Image.asset(
                        "assets/icons/mail.png",
                        height: 80,
                      ),
                    ),
                    const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 24),
                    BlurredArea(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Obx(() => TextField(
                            controller: controller.emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Address",
                              hintStyle: const TextStyle(color: Colors.grey),
                              suffixIcon: _toolTip(controller.emailError.value),
                            ),
                          )),
                    )),
                    const SizedBox(height: 16),
                    BlurredArea(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Obx(() => TextFormField(
                            controller: controller.passwordTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Colors.grey),
                              suffixIcon:
                                  _toolTip(controller.passwordError.value),
                            ),
                            obscureText: true,
                          )),
                    )),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        controller.signIn();
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [Color(0xff3d80fd), Color(0xff3648ef)],
                            )),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account? "),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(SignUpScreen.routeName)?.then((value) {
                              if (value != null &&
                                  value is List &&
                                  value[0] != null) {
                                controller.emailTextController.text = value[0];
                              }
                            });
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _toolTip(var value) {
    return value.isEmpty
        ? const SizedBox()
        : Tooltip(
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8)),
            message: value,
            child: const Icon(
              Icons.info_outline,
              color: Colors.red,
            ),
          );
  }
}
