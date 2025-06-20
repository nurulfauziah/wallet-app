class TransactionResponse {
  final List<TransactionModel> transactions;
  final int total;
  final int page;
  final int limit;

  TransactionResponse({
    required this.transactions,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionModel.fromJson(e))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'transactions': transactions.map((e) => e.toJson()).toList(),
        'total': total,
        'page': page,
        'limit': limit,
      };
}

class TransactionModel {
  final int id;
  final int walletId;
  final String type;
  final num amount;
  final String? description;
  final String? referenceId;
  final DateTime timestamp;
  final int? relatedTransactionId;

  TransactionModel({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.description,
    required this.referenceId,
    required this.timestamp,
    required this.relatedTransactionId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int,
      walletId: json['walletId'] as int,
      type: json['type'] as String,
      amount: json['amount'] as num,
      description: json['description'] as String?,
      referenceId: json['referenceId'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      relatedTransactionId: json['relatedTransactionId'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'walletId': walletId,
        'type': type,
        'amount': amount,
        'description': description,
        'referenceId': referenceId,
        'timestamp': timestamp.toIso8601String(),
        'relatedTransactionId': relatedTransactionId,
      };
}
