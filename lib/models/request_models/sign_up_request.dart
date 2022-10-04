class SignUpRequest {
  final String username;
  final String domain;
  final String password;

  SignUpRequest({
    required this.username,
    required this.domain,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "address": "$username@$domain",
        "password": password,
      };
}
