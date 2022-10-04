import 'dart:convert';

import 'package:exercise/models/request_models/sign_in_request.dart';
import 'package:exercise/models/request_models/sign_up_request.dart';
import 'package:exercise/models/response_models/sign_in_response.dart';
import 'package:exercise/models/response_models/sign_up_response.dart';
import 'package:exercise/utility/apis.dart';
import 'package:exercise/utility/network_error_handler.dart';
import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  static final AuthProvider _ins = AuthProvider._();

  AuthProvider._();

  factory AuthProvider() {
    return _ins;
  }

  signUp({required SignUpRequest request}) async {
    Response? response;
    try {
      response = await post(Apis.account, request.toJson());
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! <= 299) {
        return SignUpSuccessResponse.fromJson(
          response.body is Map ? response.body : jsonDecode(response.body),
        );
      }
      if (response.statusCode == 400) {
        return InvalidSignUpInput.fromJson(
          response.body is Map ? response.body : jsonDecode(response.body),
        );
      }
      if (response.statusCode == 422) {
        return SignUpFailedResponse.fromJson(
          response.body is Map ? response.body : jsonDecode(response.body),
        );
      }
    } catch (e) {

      if (response != null) return NetworkErrorHandler.errorHandler(response);
      return e.toString();
    }
  }

  Future signOut() async {}

  signIn({required SignInRequest request}) async {
    Response? response;
    try {
      response = await post(Apis.getToken, request.toJson());
      if (response.statusCode != null && response.statusCode! == 200) {
        return SignInSuccessResponse.fromJson(
          response.body is Map ? response.body : jsonDecode(response.body),
        );
      }
      if (response.statusCode == 401) {
        return SignInFailedResponse.fromJson(
          response.body is Map ? response.body : jsonDecode(response.body),
        );
      }
    } catch (e) {
      if (response?.statusCode == 400) {
        return SignInFailedResponse.fromJson(
          response?.body is Map ? response?.body : jsonDecode(response?.body),
        );
      }
      if (response != null) return NetworkErrorHandler.errorHandler(response);
      return e.toString();
    }
  }
}
