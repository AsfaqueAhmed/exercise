import 'dart:convert';

import 'package:get/get.dart';

class NetworkErrorHandler {
  static dynamic errorHandler(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return response.body is Map ? response.body : jsonDecode(response.body);
      case 500:
        throw "Server Error pls retry later";
      case 403:
        throw 'Error occurred pls check internet and retry.';
      default:
        throw 'Error occurred retry';
    }
  }
}
