import 'dart:convert';

import 'package:exercise/models/request_models/sign_in_request.dart';
import 'package:exercise/models/request_models/sign_up_request.dart';
import 'package:exercise/models/response_models/domain_list_response.dart';
import 'package:exercise/models/response_models/sign_in_response.dart';
import 'package:exercise/models/response_models/sign_up_response.dart';
import 'package:exercise/utility/apis.dart';
import 'package:exercise/utility/network_error_handler.dart';
import 'package:get/get.dart';

class DomainProvider extends GetConnect {
  static final DomainProvider _ins = DomainProvider._();

  DomainProvider._();

  factory DomainProvider() {
    return _ins;
  }

  loadDomains() async {
    Response? response;
    try {
      response = await get(Apis.domainList);
      if (response.statusCode == 200) {
        return DomainListResponse.fromJson(
          response.body is Map ? response.body : jsonDecode(response.body),
        );
      }
    } catch (e) {
      if (response != null) return NetworkErrorHandler.errorHandler(response);
      return e.toString();
    }
  }
}
