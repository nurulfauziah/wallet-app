import 'package:dio/dio.dart';
import 'package:wallet_app/core/error/exception_handler.dart';

abstract class BaseRemoteDataSource {
  Future<T> request<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw ExceptionHandler.handle(e);
    }
  }
}
