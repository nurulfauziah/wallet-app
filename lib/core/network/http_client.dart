import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/core/helper/preference_helper.dart';
import 'package:wallet_app/core/router/router.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class HttpClient {
  static const String divider = "\n------------------------------------";
  static final Dio _dio = Dio();
  final context = navigatorKey.currentContext;

  final String baseApi = 'https://wallet-testing-murex.vercel.app';

  static const _connectTimeoutDefault = Duration(seconds: 60);
  static const _receiveTimeoutDefault = Duration(seconds: 60);
  static const _sendTimeoutDefault = Duration(seconds: 60);

  Future<Response> get(String endpoint,
      {bool isUseToken = true,
      Map<String, dynamic>? params,
      dynamic data,
      Function(int, int)? progress,
      Options? options}) async {
    final preferencesHelper = getIt<PreferencesHelper>();

    log('get');
    final dio = await client(isUseToken: isUseToken);

    dio.options.headers['Authorization'] =
        'Bearer ${await preferencesHelper.getToken}';
    return await dio.get(baseApi + endpoint,
        data: data,
        queryParameters: params,
        onReceiveProgress: progress,
        options: options);
  }

  Future<Response> post(String endpoint,
      {bool isUseToken = true,
      Map<String, dynamic>? params,
      Function(int, int)? receiveProgress,
      Function(int, int)? progress,
      Options? options,
      dynamic data}) async {
    final preferencesHelper = getIt<PreferencesHelper>();

    String token = await preferencesHelper.getToken;
    final dio = await client(isUseToken: isUseToken);
    // log("token ${dio.toString()}");

    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.post(baseApi + endpoint,
        queryParameters: params,
        onReceiveProgress: receiveProgress,
        options: options,
        onSendProgress: progress,
        data: data);
  }

  Future<Response> postFormData(String endpoint,
      {bool isUseToken = true,
      Map<String, dynamic>? params,
      Function(int, int)? receiveProgress,
      Function(int, int)? progress,
      Options? options,
      dynamic data}) async {
    final preferencesHelper = getIt<PreferencesHelper>();

    String token = await preferencesHelper.getToken;
    log("token $token");
    _dio.options.headers['Authorization'] = 'Bearer $token';
    _dio.options.headers['Content-Type'] = 'multipart/form-data';
    return await _dio.post(endpoint,
        queryParameters: params,
        onReceiveProgress: receiveProgress,
        options: options,
        onSendProgress: progress,
        data: data);
  }

  Future<Response> put(String endpoint,
      {bool isUseToken = true,
      Map<String, dynamic>? params,
      Function(int, int)? receiveProgress,
      Function(int, int)? progress,
      Options? options,
      dynamic data}) async {
    final preferencesHelper = getIt<PreferencesHelper>();

    _dio.options.headers['Authorization'] =
        'Bearer ${await preferencesHelper.getToken}';
    return await _dio.put(baseApi + endpoint,
        queryParameters: params,
        onReceiveProgress: receiveProgress,
        onSendProgress: progress,
        options: options,
        data: data);
  }

  Future<Response> patch(String endpoint,
      {bool isUseToken = true,
      Map<String, dynamic>? params,
      Function(int, int)? receiveProgress,
      Function(int, int)? progress,
      Options? options,
      dynamic data}) async {
    final preferencesHelper = getIt<PreferencesHelper>();

    _dio.options.headers['Authorization'] =
        'Bearer ${await preferencesHelper.getToken}';
    return await _dio.patch(baseApi + endpoint,
        queryParameters: params,
        onReceiveProgress: receiveProgress,
        onSendProgress: progress,
        options: options,
        data: data);
  }

  Future<Response> delete(String endpoint,
      {bool isUseToken = true,
      Map<String, dynamic>? params,
      Options? options,
      dynamic data}) async {
    final preferencesHelper = getIt<PreferencesHelper>();

    _dio.options.headers['Authorization'] =
        'Bearer ${await preferencesHelper.getToken}';
    return await _dio.delete(baseApi + endpoint,
        queryParameters: params, options: options, data: data);
  }

  Future<Response> download(String endpoint,
      {bool isUseToken = true,
      savePath,
      dynamic data,
      Options? options,
      Function(int, int)? progress,
      Map<String, dynamic>? params}) async {
    final preferencesHelper = getIt<PreferencesHelper>();

    _dio.options.headers['Authorization'] =
        'Bearer ${await preferencesHelper.getToken}';
    return await _dio.download(endpoint, savePath,
        data: data,
        options: options,
        onReceiveProgress: progress,
        queryParameters: params);
  }

  Future<Dio> client(
      {isUseToken = true,
      Duration? connectTimeout,
      Duration? receiveTimeout,
      Duration? sendTimeout}) async {
    // final client = Dio();
    final preferencesHelper = getIt<PreferencesHelper>();

    String token;
    if (isUseToken) {
      token = await preferencesHelper.getToken;
    } else {
      token = '';
    }
    _dio.interceptors.add(interceptor(token,
        connectTimeout: connectTimeout ?? _connectTimeoutDefault,
        receiveTimeout: receiveTimeout ?? _receiveTimeoutDefault,
        sendTimeout: sendTimeout ?? _sendTimeoutDefault));
    return _dio;
  }

  InterceptorsWrapper interceptor(String token,
      {Duration connectTimeout = _connectTimeoutDefault,
      Duration receiveTimeout = _receiveTimeoutDefault,
      Duration sendTimeout = _sendTimeoutDefault}) {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        log('message request ${options.path}:${options.data} params : ${options.queryParameters}');

        // String? token = await StorageService().readAccessToken();
        // options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      onResponse: (options, handler) {
        if (kDebugMode) {
          log('message response ${options.requestOptions.method}: ${options.requestOptions.path}: ${jsonEncode(options.data)}');
        }

        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        EasyLoading.dismiss();
        if (kDebugMode) {
          log('message onError ${e.error} ${e.requestOptions.path}: ${jsonEncode(e.response?.data)} ${jsonEncode(e.response?.statusCode)}');
        }
        // log(e.response!.data.toString());
        if (e.response != null) {
          final preferencesHelper = getIt<PreferencesHelper>();

          // ApiServiceAuth apiServiceAuth = ApiServiceAuth();
          // log('masuk error dio ga? ${e.response?.statusCode}');
          if (e.response?.statusCode == 401) {
            preferencesHelper.removeStringSharedPref('token');
            // log('masuk error dio ga 401?');
            // GoRoute(path: login);
            context!.pushNamed(login);

            // Navigation.pushNoData(loginRoute);
            RequestOptions requestOptions = e.requestOptions;
          } else {
            // log('message else 2');

            handler.next(e);
          }
        }
      },
    );
  }
}

Future<Response> refreshToken() async {
  // Response? response;
  // Repository repository = Repository();
  var dio = Dio();
  final Uri apiUrl = Uri.parse(
      "https://dev.api.alhikmah.capioteknologi.xyz/merchants/auth/token/refresh");

  // try {
  var response = await dio.postUri(apiUrl);
  final preferencesHelper = getIt<PreferencesHelper>();

  if (response.statusCode == 200 || response.statusCode == 201) {
    preferencesHelper.setStringSharedPref(
        'access_token', response.data['data']['access_token'].toString());
    preferencesHelper.setStringSharedPref(
        'refresh_token', response.data['data']['refresh_token'].toString());
    preferencesHelper.setStringSharedPref(
        'expires_at', response.data['data']['expires_at'].toString());
  } else {
    log('berhasil else?');
    print(response.toString()); //TODO: logout
    // return response;
  }
  try {
    return response;
  } on DioException {
    preferencesHelper.removeStringSharedPref('access_token');
    // Navigation.pushNoData(loginRoute);
    return response;
  }
  // }
  // catch (e) {
  //   print(e.toString()); //TODO: logout
  //       return response!;

  // }
}
