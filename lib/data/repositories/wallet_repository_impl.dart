import 'package:wallet_app/data/datasources/wallet_remote_data_source.dart';
import 'package:wallet_app/data/models/create_wallet_response_model.dart';
import 'package:wallet_app/domain/repositories/wallet_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remote;

  WalletRepositoryImpl(this.remote);

  @override
  Future<List<WalletResponseModel>> getWallets() => remote.getWallets();
  @override
  Future<WalletResponseModel> createWallets(
          {String? currency, double? initialBalance}) =>
      remote.createWallets(currency: currency, initialBalance: initialBalance);

  @override
  Future<WalletResponseModel> getDetailWallet({
    required String id,
  }) =>
      remote.getDetailWallet(
        id: id,
      );
}
