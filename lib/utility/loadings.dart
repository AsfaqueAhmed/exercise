import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading {
  Loading._();

  static show() {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: true,
    );
  }

  static close() {
    Get.back();
  }
}
