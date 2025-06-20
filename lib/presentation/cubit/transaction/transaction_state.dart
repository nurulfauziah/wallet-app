import 'package:wallet_app/data/models/transaction_detail_model.dart';
import 'package:wallet_app/data/models/transaction_response_model.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class GetListTransactionLoading extends TransactionState {}

class GetListTransactionSuccess extends TransactionState {
  final TransactionResponse data;
  GetListTransactionSuccess(this.data);
}

class GetListTransactionError extends TransactionState {
  final String message;
  GetListTransactionError(this.message);
}

class GetDetailTransactionLoading extends TransactionState {}

class GetDetailTransactionSuccess extends TransactionState {
  final TransactionDetailModel data;
  GetDetailTransactionSuccess(this.data);
}

class GetDetailTransactionError extends TransactionState {
  final String message;
  GetDetailTransactionError(this.message);
}

class PostDepositLoading extends TransactionState {}

class PostDepositSuccess extends TransactionState {}

class PostDepositError extends TransactionState {
  final String message;
  PostDepositError(this.message);
}

class PostWithdrawalLoading extends TransactionState {}

class PostWithdrawalSuccess extends TransactionState {}

class PostWithdrawalError extends TransactionState {
  final String message;
  PostWithdrawalError(this.message);
}
