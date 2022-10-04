import 'dart:convert';

import 'package:exercise/controller_global/token_controller.dart';
import 'package:exercise/models/request_models/sign_in_request.dart';
import 'package:exercise/models/request_models/sign_up_request.dart';
import 'package:exercise/models/response_models/email_deatsil_response.dart';
import 'package:exercise/models/response_models/email_list_response.dart';
import 'package:exercise/models/response_models/email_update_response.dart';
import 'package:exercise/models/response_models/sign_in_response.dart';
import 'package:exercise/models/response_models/sign_up_response.dart';
import 'package:exercise/utility/apis.dart';
import 'package:exercise/utility/network_error_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class EmailProvider extends GetConnect {
  static final EmailProvider _ins = EmailProvider._();

  EmailProvider._();

  factory EmailProvider() {
    return _ins;
  }

  loadEmails() async {
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] =
          "Bearer ${Get.find<TokenController>().getToken()}";
      return request;
    });

    Response? response;
    try {
      response = await get(Apis.messageList(1));
      if (response.statusCode == 200) {
        return EmailListResponse.fromJson(
          response.body is Map ? response.body : jsonDecode(response.body),
        );
      }
    } catch (e) {
      if (response != null) return NetworkErrorHandler.errorHandler(response);
      return e.toString();
    }
  }

  emailSeen(dynamic id) async {
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] =
          "Bearer ${Get.find<TokenController>().getToken()}";
      return request;
    });

    Response? response;
    try {
      response = await patch(Apis.messageDetails(id), {"seen": true},contentType: 'application/merge-patch+json');
      print(response.body);
      if (response.statusCode == 200) {
        return EmailUpdateResponse.fromJson(
          response.body is Map ? response.body : jsonDecode(response.body),
        );
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      if (response != null) return NetworkErrorHandler.errorHandler(response);
      return e.toString();
    }
  }

  loadEmail(String id) async {
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] =
          "Bearer ${Get.find<TokenController>().getToken()}";
      return request;
    });

    Response? response;
    try {
      response = await get(Apis.messageDetails(id));
      if (response.statusCode == 200) {
        return EmailDetailsResponse.fromJson(
          response.body is Map ? response.body : jsonDecode(response.body),
        );
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      if (response != null) return NetworkErrorHandler.errorHandler(response);
      return e.toString();
    }
  }
}
