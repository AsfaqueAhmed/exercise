import 'package:exercise/controller_global/token_controller.dart';
import 'package:exercise/models/request_models/sign_in_request.dart';
import 'package:exercise/models/response_models/sign_in_response.dart';
import 'package:exercise/pages/email_list_page/email_list.dart';
import 'package:exercise/providers/auth_provider.dart';
import 'package:exercise/utility/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  AuthProvider authProvider = AuthProvider();

  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  var emailError = "".obs;
  var passwordError = "".obs;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }

  void signIn() async {
    bool ok = true;
    emailError.value = "";
    passwordError.value = "";
    if (!GetUtils.isEmail(emailTextController.text.trim())) {
      emailError("Provide valid email");
      ok = false;
    }
    if (!GetUtils.isLengthBetween(passwordTextController.text.trim(), 6, 10)) {
      passwordError("Provide password with length 6 tpp 10");
      ok = false;
    } else if (passwordTextController.text.trim().contains(" ")) {
      passwordError("Password can't contain `space`");
      ok = false;
    }
    if (!ok) return;

    Loading.show();
    var response = await authProvider.signIn(
        request: SignInRequest(
            address: emailTextController.text,
            password: passwordTextController.text));
    Loading.close();

    if (response is SignInSuccessResponse && response.token != null) {
      Get.find<TokenController>().setToken(response.token!);
      Get.offAllNamed(EmailListScreen.routeName);
    } else if (response is SignInFailedResponse) {
      showError(message: response.message);
    } else if (response is String) {
      showError(message: response);
    } else {
      showError();
    }
  }

  showError({String? message}) {
    Get.showSnackbar(
      GetSnackBar(
        margin: const EdgeInsets.all(16),
        title: "Failed",
        message: message ?? "Sign in failed",
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 8,
      ),
    );
  }
}
