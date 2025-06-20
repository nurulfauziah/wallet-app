class TransactionDetailModel {
  final int id;
  final int walletId;
  final String type;
  final num amount;
  final String? description;
  final String? referenceId;
  final String timestamp;
  final int? relatedTransactionId;

  TransactionDetailModel({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    this.description,
    this.referenceId,
    required this.timestamp,
    this.relatedTransactionId,
  });

  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailModel(
      id: json['id'],
      walletId: json['walletId'],
      type: json['type'],
      amount: json['amount'],
      description: json['description'],
      referenceId: json['referenceId'],
      timestamp: json['timestamp'],
      relatedTransactionId: json['relatedTransactionId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'walletId': walletId,
      'type': type,
      'amount': amount,
      'description': description,
      'referenceId': referenceId,
      'timestamp': timestamp,
      'relatedTransactionId': relatedTransactionId,
    };
  }
}
