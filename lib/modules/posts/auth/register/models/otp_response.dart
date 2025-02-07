class OtpResponse {
  final int ttl;

  OtpResponse({required this.ttl});

  Map<String, dynamic> toJson() {
    return {
      'ttl': ttl,
    };
  }

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      ttl: json['ttl'],
    );
  }
}
