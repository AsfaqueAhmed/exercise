import 'package:exercise/pages/email_details_page/email_details.dart';
import 'package:exercise/pages/email_details_page/email_details_controller.dart';
import 'package:exercise/pages/email_list_page/email_list.dart';
import 'package:exercise/pages/email_list_page/email_list_controller.dart';
import 'package:exercise/pages/sign_in_page/sign_in_page.dart';
import 'package:exercise/pages/sign_in_page/sign_in_page_controller.dart';
import 'package:exercise/pages/sign_up_page/sign_up_page.dart';
import 'package:exercise/pages/sign_up_page/sign_up_page_controller.dart';
import 'package:exercise/pages/splash_page/splah_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: SplashPage.routeName,
      getPages: [
        GetPage(
          name: SplashPage.routeName,
          page: () => const SplashPage(),
        ),
        GetPage(
          name: SignInScreen.routeName,
          page: () => const SignInScreen(),
          binding: BindingsBuilder(() {
            Get.put(SignInController());
          }),
        ),
        GetPage(
          name: SignUpScreen.routeName,
          page: () => const SignUpScreen(),
          binding: BindingsBuilder(() {
            Get.put(SignUpController());
          }),
        ),
        GetPage(
          name: EmailListScreen.routeName,
          page: () => const EmailListScreen(),
          binding: BindingsBuilder(() {
            Get.put(EmailListController());
          }),
        ),
        GetPage(
          name: EmailDetailsScreen.routeName,
          page: () => const EmailDetailsScreen(),
          binding: BindingsBuilder(() {
            Get.put(EmailDetailsController());
          }),
        ),
      ],
    );
  }
}
