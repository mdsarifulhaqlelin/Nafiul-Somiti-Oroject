class LoanModel {
  final String? id;
  final String borrowerId;
  final String borrowerName;
  final String adminId;
  final double loanAmount;
  final double interestRate;
  final double totalPayable;
  final double monthlyInstallment;
  final String status; // 'pending', 'approved', 'rejected', 'paid'
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;

  LoanModel({
    this.id,
    required this.borrowerId,
    required this.borrowerName,
    required this.adminId,
    required this.loanAmount,
    required this.interestRate,
    required this.totalPayable,
    required this.monthlyInstallment,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'borrowerId': borrowerId,
      'borrowerName': borrowerName,
      'adminId': adminId,
      'loanAmount': loanAmount,
      'interestRate': interestRate,
      'totalPayable': totalPayable,
      'monthlyInstallment': monthlyInstallment,
      'status': status,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory LoanModel.fromMap(String id, Map<String, dynamic> map) {
    return LoanModel(
      id: id,
      borrowerId: map['borrowerId'] ?? '',
      borrowerName: map['borrowerName'] ?? '',
      adminId: map['adminId'] ?? '',
      loanAmount: (map['loanAmount'] ?? 0.0).toDouble(),
      interestRate: (map['interestRate'] ?? 0.0).toDouble(),
      totalPayable: (map['totalPayable'] ?? 0.0).toDouble(),
      monthlyInstallment: (map['monthlyInstallment'] ?? 0.0).toDouble(),
      status: map['status'] ?? 'pending',
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] ?? 0),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] ?? 0),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }
}