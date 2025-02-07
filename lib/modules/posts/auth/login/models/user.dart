class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final double balance;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.balance,
    required this.token,
  });

  // Factory method to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String? ?? "",
      // Handle null case
      phone: json['phone'] as String,
      balance: (json['balance'] as num).toDouble(),
      // Ensure double type
      token: json['token'] as String,
    );
  }

  // Method to convert a User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'balance': balance,
      'token': token,
    };
  }
}
