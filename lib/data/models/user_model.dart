class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String role; // 'admin' or 'borrower'
  final double totalLoanGiven;
  final double totalLoanTaken;
  final DateTime createdAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.totalLoanGiven = 0.0,
    this.totalLoanTaken = 0.0,
    required this.createdAt,
  });

  // Convert Model to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'totalLoanGiven': totalLoanGiven,
      'totalLoanTaken': totalLoanTaken,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  // Create Model from Firestore Document
  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'borrower',
      totalLoanGiven: (map['totalLoanGiven'] ?? 0.0).toDouble(),
      totalLoanTaken: (map['totalLoanTaken'] ?? 0.0).toDouble(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }
}