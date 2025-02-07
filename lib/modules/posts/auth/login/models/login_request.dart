import 'dart:convert';

class LoginRequest {
  final String phone;
  final String password;

  LoginRequest({
    required this.phone,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      phone: json['phone'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  factory LoginRequest.fromJsonString(String jsonString) =>
      LoginRequest.fromJson(jsonDecode(jsonString));

  @override
  String toString() {
    return 'LoginRequest{phone: $phone, password: $password}';
  }
}
