import 'package:exercise/models/response_models/email_list_response.dart';
import 'package:exercise/providers/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailListController extends GetxController {
  final EmailProvider emailProvider = EmailProvider();

  RxList<Email> emails = <Email>[].obs;

  var loading = true.obs;

  @override
  void onInit() {
    loadEmails();
    super.onInit();
  }

  loadEmails() async {
    loading.value = true;
    var response = await emailProvider.loadEmails();
    loading.value = false;
    if (response is EmailListResponse) {
      emails(response.emails);
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
