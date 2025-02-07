class OtpRequest {
  final String phone;
  final String name;
  final String password;

  OtpRequest({required this.phone, required this.name, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
    };
  }

  factory OtpRequest.fromJson(Map<String, dynamic> json) {
    return OtpRequest(
      name: json['name'],
      phone: json['phone'],
      password: json['password'],
    );
  }
}
