import 'package:dio/dio.dart';
import 'package:wallet_app/core/error/exception_handler.dart';
import 'package:wallet_app/core/network/http_client.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet_app/data/models/login_response_model.dart';
import 'package:wallet_app/data/models/register_response_model.dart';

@LazySingleton()
class AuthRemoteDataSource {
  final HttpClient client;

  AuthRemoteDataSource(this.client);

  Future<LoginResponseModel> postLogin({
    required String email,
    required String password,
  }) async {
 
      final res = await client
          .post('/auth/login', data: {'email': email, 'password': password});
      return LoginResponseModel.fromJson(res.data);
   
  }

  Future<RegisterResponseModel> postRegister({
    required String email,
    required String password,
    String? name,
  }) async {
 
      final res = await client.post('/auth/register',
          data: {'email': email, 'password': password, 'name': name});
      return RegisterResponseModel.fromJson(res.data);
   
  }
}
