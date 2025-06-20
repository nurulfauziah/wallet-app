import 'package:wallet_app/data/models/create_wallet_response_model.dart';

abstract class WalletState {}

class WalletLoading extends WalletState {}

class WalletSuccess extends WalletState {
  final List<WalletResponseModel> data;
  WalletSuccess(this.data);
}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}

class CreateWalletLoading extends WalletState {}

class CreateWalletSuccess extends WalletState {
  final WalletResponseModel data;
  CreateWalletSuccess(this.data);
}

class CreateWalletError extends WalletState {
  final String message;
  CreateWalletError(this.message);
}

class GetDetailWalletLoading extends WalletState {}

class GetDetailWalletSuccess extends WalletState {
  final WalletResponseModel data;
  GetDetailWalletSuccess(this.data);
}

class GetDetailWalletError extends WalletState {
  final String message;
  GetDetailWalletError(this.message);
}
