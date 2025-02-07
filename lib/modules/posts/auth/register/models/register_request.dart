class RegisterRequest {
  final String? name;
  final String? phone;
  final String? password;
  final String otp;

  RegisterRequest({
    required this.name,
    this.phone,
    this.password,
    required this.otp,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
      'otp': otp,
    };
  }
}
