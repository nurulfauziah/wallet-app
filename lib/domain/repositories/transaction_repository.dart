import 'package:wallet_app/data/models/transaction_detail_model.dart';
import 'package:wallet_app/data/models/transaction_response_model.dart';

abstract class TransactionRepository {
  Future<TransactionResponse> getListTransactions(
      {required int walletId, int? page});
  Future<TransactionDetailModel> getDetailTransactions(
      {required int walletId, required int id});
  Future postDeposit({required num amount, required int walletId});
  Future postWithdrawal({required num amount, required int walletId});
}
