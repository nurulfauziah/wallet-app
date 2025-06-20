import 'package:dio/dio.dart';
import 'app_exception.dart';

class ExceptionHandler {
  static AppException handle(DioException error) {
    final response = error.response;
    final data = response?.data;

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return NetworkException("Connection timeout, please try again.");
    }

    if (response?.statusCode == 401) {
      return UnauthorizedException("Unauthorized. Please login again.");
    }

    if (response?.statusCode == 400 && data['message'] is List) {
      return ValidationException((data['message'] as List).join('\n'));
    }

    if (response?.statusCode == 500) {
      return ServerException("Server error occurred.");
    }

    return UnknownException("Something went wrong.");
  }
}
