import 'package:injectable/injectable.dart';
import 'package:wallet_app/data/datasources/transaction_remote_data_source.dart';
import 'package:wallet_app/data/models/transaction_detail_model.dart';
import 'package:wallet_app/data/models/transaction_response_model.dart';
import 'package:wallet_app/domain/repositories/transaction_repository.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remote;

  TransactionRepositoryImpl(this.remote);

  @override
  Future<TransactionResponse> getListTransactions(
          {required int walletId, int? page}) =>
      remote.getListTransactions(walletId: walletId, page: page);
  @override
  Future<TransactionDetailModel> getDetailTransactions(
          {required int walletId, required int id}) =>
      remote.getDetailTransactions(walletId: walletId, id: id);
  @override
  Future postDeposit({required num amount, required int walletId}) =>
      remote.postDeposit(amount: amount, walletId: walletId);
  @override
  Future postWithdrawal({required num amount, required int walletId}) =>
      remote.postWithdrawal(amount: amount, walletId: walletId);
}
