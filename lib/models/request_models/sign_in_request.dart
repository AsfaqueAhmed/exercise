class SignInRequest {
  final String address;
  final String password;

  SignInRequest({
    required this.address,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "address": address,
        "password": password,
      };
}
