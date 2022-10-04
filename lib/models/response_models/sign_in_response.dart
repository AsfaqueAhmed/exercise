class SignInSuccessResponse {
  String? token;

  SignInSuccessResponse({this.token});

  SignInSuccessResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}

class SignInFailedResponse {
  int? code;
  String? message;

  SignInFailedResponse({this.code, this.message});

  SignInFailedResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
