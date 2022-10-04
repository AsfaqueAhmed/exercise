import 'package:exercise/models/request_models/sign_up_request.dart';
import 'package:exercise/models/response_models/domain_list_response.dart';
import 'package:exercise/models/response_models/sign_up_response.dart';
import 'package:exercise/providers/auth_provider.dart';
import 'package:exercise/providers/domain_provider.dart';
import 'package:exercise/utility/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final AuthProvider authProvider = AuthProvider();
  final DomainProvider domainProvider = DomainProvider();

  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  Rx<String> emailError = "".obs;
  Rx<String> passwordError = "".obs;

  Rx<Domain?> domain = Rx<Domain?>(null);
  RxList<Domain> domains = <Domain>[].obs;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    loadDomains();
    super.onInit();
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }

  void signUp() async {
    bool ok = true;
    emailError.value = "";
    passwordError.value = "";
    if (emailTextController.text.trim().contains(" ") ||
        emailTextController.text.trim().isEmpty) {
      emailError("Provide valid username");
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
    var response = await authProvider.signUp(
      request: SignUpRequest(
        username: emailTextController.text,
        password: passwordTextController.text,
        domain: domain.value!.domain!,
      ),
    );
    Loading.close();

    if (response is SignUpSuccessResponse) {
      Get.back(result: ["${emailTextController.text}@${domain.value!.domain}"]);
      Get.showSnackbar(GetSnackBar(
        title: "Success",
        message:
            "Sign up  success with address ${emailTextController.text}@${domain.value!.domain}.",
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 5),
      ));
    } else if (response is SignUpFailedResponse) {
      response.violations?.forEach((element) {
        if (element.propertyPath == "address") {
          emailError(element.message);
        }
        if (element.propertyPath == "password") {
          passwordError(element.message);
        }
      });
      showError(message: response.hydraDescription);
    } else if (response is InvalidSignUpInput) {
      showError(message: response.hydraDescription);
    } else if (response is String) {
      showError(message: response);
    } else {
      showError();
    }
  }

  loadDomains() async {
    domains([]);
    var response = await domainProvider.loadDomains();
    if (response is DomainListResponse) {
      domains(response.doaminList);
    } else {
      Get.back();
      showError(message: response);
    }
  }

  setDomain(Domain domainName) {
    domain(domainName);
  }

  showError({String? message}) {
    Get.showSnackbar(GetSnackBar(
      title: "Failed",
      message: message ?? "Sign up failed",
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 5),
    ));
  }
}
