import 'package:dio/dio.dart';
import 'package:wallet_app/core/error/exception_handler.dart';
import 'package:wallet_app/core/network/http_client.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet_app/data/models/create_wallet_response_model.dart';

@LazySingleton()
class WalletRemoteDataSource {
  final HttpClient client;

  WalletRemoteDataSource(this.client);

  Future<List<WalletResponseModel>> getWallets() async {
    final res = await client.get('/wallets');
    final List<dynamic> data = res.data;

    return data.map((e) => WalletResponseModel.fromJson(e)).toList();
  }

  Future<WalletResponseModel> createWallets(
      {String? currency, double? initialBalance}) async {
   
      final res = await client.post('/wallets',
          data: {'currency': currency, 'initialBalance': initialBalance});
      return WalletResponseModel.fromJson(res.data);
   
  }

  Future<WalletResponseModel> getDetailWallet({
    required String id,
  }) async {
    final res = await client.get('/wallets/$id');
    return WalletResponseModel.fromJson(res.data);
  }
}
