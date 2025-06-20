import 'package:injectable/injectable.dart';
import 'package:wallet_app/core/network/http_client.dart';
import 'package:wallet_app/data/models/transaction_detail_model.dart';
import 'package:wallet_app/data/models/transaction_response_model.dart';

@LazySingleton()
class TransactionRemoteDataSource {
  final HttpClient client;

  TransactionRemoteDataSource(this.client);

  Future<TransactionResponse> getListTransactions(
      {required int walletId, int? page}) async {
    final res = await client.get('/wallets/$walletId/transactions',
        params: {"page": page, "limit": 10});
    return TransactionResponse.fromJson(res.data);
  }

  Future<TransactionDetailModel> getDetailTransactions(
      {required int walletId, required int id}) async {
    final res = await client.get(
      '/wallets/$walletId/transactions/$id',
    );
    return TransactionDetailModel.fromJson(res.data);
  }

  Future postDeposit({required num amount, required int walletId}) async {
    final res =
        await client.post('/wallets/$walletId/transactions/deposit', data: {
      "amount": amount,
    });
    return res.data;
  }

  Future postWithdrawal({required num amount, required int walletId}) async {
    final res =
        await client.post('/wallets/$walletId/transactions/withdrawal', data: {
      "amount": amount,
    });
    return res.data;
  }
}
