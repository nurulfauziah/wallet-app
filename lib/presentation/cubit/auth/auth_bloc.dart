import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/core/helper/preference_helper.dart';
import 'package:wallet_app/domain/repositories/auth_repository.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;
  final PreferencesHelper prefs;

  AuthCubit(this.repo, this.prefs) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final token = await prefs.getToken;
    if (token.isNotEmpty) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> logout() async {
    prefs.removeStringSharedPref('token');
    emit(AuthUnauthenticated());
  }

  Future<void> register({
    required String email,
    required String password,
    String? name,
  }) async {
    emit(AuthLoading());
    try {
      final data = await repo.postRegister(
        email: email,
        password: password,
        name: name,
      );
      emit(RegisterSuccess(data));
    } on DioException catch (e) {
      emit(RegisterError(e.response?.data['message'][0]));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final data = await repo.postLogin(
        email: email,
        password: password,
      );
      emit(LoginSuccess(data));
    } on DioException catch (e) {
      emit(LoginError(e.response?.data['message'][0]));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
