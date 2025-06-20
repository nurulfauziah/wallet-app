import 'package:wallet_app/data/models/login_response_model.dart';
import 'package:wallet_app/data/models/register_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> postLogin({
    required String email,
    required String password,
  });
  Future<RegisterResponseModel> postRegister({
    required String email,
    required String password,
    String? name,
  });
}
