import 'package:exercise/controller_global/token_controller.dart';
import 'package:exercise/pages/email_list_page/email_list.dart';
import 'package:exercise/pages/sign_in_page/sign_in_page.dart';
import 'package:exercise/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/";

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final TokenController controller = Get.put(
    TokenController(),
    permanent: true,
  );

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Get.offNamed(controller.haveToken()
            ? EmailListScreen.routeName
            : SignInScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Center(
          child: Image.asset(
            "assets/icons/mail.png",
            height: 120,
          ),
        ),
      ),
    );
  }
}
