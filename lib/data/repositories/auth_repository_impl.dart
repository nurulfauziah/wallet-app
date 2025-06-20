import 'package:wallet_app/data/datasources/auth_remote_data_source.dart';
import 'package:wallet_app/data/models/login_response_model.dart';
import 'package:wallet_app/data/models/register_response_model.dart';
import 'package:wallet_app/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<LoginResponseModel> postLogin({
    required String email,
    required String password,
  }) =>
      remote.postLogin(email: email, password: password);

  @override
  Future<RegisterResponseModel> postRegister({
    required String email,
    required String password,
    String? name,
  }) =>
      remote.postRegister(email: email, password: password, name: name);
}
