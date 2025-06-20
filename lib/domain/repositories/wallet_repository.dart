import 'package:wallet_app/data/models/create_wallet_response_model.dart';

abstract class WalletRepository {
  Future<List<WalletResponseModel>> getWallets();
  Future<WalletResponseModel> createWallets(
      {String? currency, double? initialBalance});
  Future<WalletResponseModel> getDetailWallet({required String id});
}
