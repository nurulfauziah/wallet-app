import 'package:wallet_app/data/models/login_response_model.dart';
import 'package:wallet_app/data/models/register_response_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthChecking extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class RegisterSuccess extends AuthState {
  final RegisterResponseModel data;
  RegisterSuccess(this.data);
}

class RegisterError extends AuthState {
  final String message;
  RegisterError(this.message);
}

class LoginSuccess extends AuthState {
  final LoginResponseModel data;
  LoginSuccess(this.data);
}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}
