import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositories/transaction_repository.dart';
import 'transaction_state.dart';

@injectable
class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository repo;
  TransactionCubit(this.repo) : super(TransactionInitial());

  void load({required int walletId, int? page}) async {
    emit(GetListTransactionLoading());
    try {
      final data =
          await repo.getListTransactions(walletId: walletId, page: page);
      emit(GetListTransactionSuccess(data));
    } catch (e) {
      emit(GetListTransactionError(e.toString()));
    }
  }

  void getDetail({required int walletId, required int id}) async {
    emit(GetDetailTransactionLoading());
    try {
      final data = await repo.getDetailTransactions(walletId: walletId, id: id);
      emit(GetDetailTransactionSuccess(data));
    } catch (e) {
      emit(GetDetailTransactionError(e.toString()));
    }
  }

  void postDeposit({required num amount, required int walletId}) async {
    emit(PostDepositLoading());
    try {
      await repo.postDeposit(amount: amount, walletId: walletId);
      emit(PostDepositSuccess());
    } on DioException catch (e) {
      emit(PostDepositError(e.response?.data['message']));
    } catch (e) {
      emit(PostDepositError(e.toString()));
    }
  }

  void postWithdrawal({required num amount, required int walletId}) async {
    emit(PostWithdrawalLoading());
    try {
      await repo.postWithdrawal(amount: amount, walletId: walletId);
      emit(PostWithdrawalSuccess());
    } on DioException catch (e) {
      emit(PostWithdrawalError(e.response?.data['message']));
    } catch (e) {
      emit(PostWithdrawalError(e.toString()));
    }
  }
}
