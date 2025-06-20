import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet_app/domain/repositories/wallet_repository.dart';
import 'package:wallet_app/presentation/cubit/wallet/wallet_state.dart';

@injectable
class WalletCubit extends Cubit<WalletState> {
  final WalletRepository repo;
  WalletCubit(this.repo) : super(WalletLoading());
  void load() async {
    try {
      final data = await repo.getWallets();
      emit(WalletSuccess(data));
    } on DioException catch (e) {
      emit(WalletError(e.response?.data['message']));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }

  Future<void> createWallet({
    String? currency,
    double? initialBalance,
  }) async {
    emit(CreateWalletLoading());
    try {
      final data = await repo.createWallets(
        currency: currency,
        initialBalance: initialBalance,
      );
      emit(CreateWalletSuccess(data));
    } on DioException catch (e) {
      emit(CreateWalletError(e.response?.data['message']));
    } catch (e) {
      emit(CreateWalletError(e.toString()));
    }
  }

  Future<void> getDetailWallet({
    required String id,
  }) async {
    emit(GetDetailWalletLoading());
    try {
      final data = await repo.getDetailWallet(
        id: id,
      );
      emit(GetDetailWalletSuccess(data));
    } on DioException catch (e) {
      emit(GetDetailWalletError(e.response?.data['message']));
    } catch (e) {
      emit(GetDetailWalletError(e.toString()));
    }
  }
}
