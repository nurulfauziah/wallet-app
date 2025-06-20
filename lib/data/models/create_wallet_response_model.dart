class WalletResponseModel {
  final int id;
  final int userId;
  final int balance;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;

  WalletResponseModel({
    required this.id,
    required this.userId,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });
  factory WalletResponseModel.fromJson(Map<String, dynamic> json) {
    return WalletResponseModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      balance: json['balance'] as int,
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
