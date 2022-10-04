import 'package:exercise/models/response_models/email_deatsil_response.dart';
import 'package:exercise/models/response_models/email_update_response.dart';
import 'package:exercise/pages/email_list_page/email_list_controller.dart';
import 'package:exercise/providers/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailDetailsController extends GetxController {
  final EmailProvider emailProvider = EmailProvider();

  Rx<EmailDetailsResponse?> emailDetails = Rx<EmailDetailsResponse?>(null);

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 300), () {
      loadEmail();
    });

    super.onInit();
  }

  loadEmail() async {
    print(Get.arguments[0]);
    var response = await emailProvider.loadEmail(Get.arguments[0]);
    if (response is EmailDetailsResponse) {
      emailDetails(response);
      response = await emailProvider.emailSeen(Get.arguments[0]);
      if (response is EmailUpdateResponse) {
        Get.find<EmailListController>().loadEmails();
      }
    } else {
      showError(message: response);
    }
  }

  showError({String? message}) {
    Get.showSnackbar(GetSnackBar(
      title: "Failed",
      message: message ?? "Email obtain failed",
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 5),
    ));
  }
}
