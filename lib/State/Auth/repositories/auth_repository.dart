import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application_1/Exceptions/request_api_error.dart';
import 'package:flutter_application_1/State/Auth/bloc/authentication_bloc.dart';
import 'package:flutter_application_1/State/Auth/bloc/authentication_event.dart';

class AuthRepository {
  final FlutterSecureStorage storage;
  final Dio dio;
  static const uri = 'https://reqres.in/api/login';
  // static const logoutUri = '/auth/logout/';
  static const key = 'token';
  const AuthRepository({required this.dio, required this.storage})
      : assert(storage != null),
        assert(dio != null);

  Future<String> authenticate({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(uri, data: {
      'email': email,
      'password': password,
    });
    if (response.statusCode != 200) {
      throw const RequestApiError('Password anda salah');
    }
    return response.data['token'];
  }

  // void addInterceptor(String token, AuthenticationBloc authenticationBloc) {
  //   dio.interceptors
  //       .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
  //     options.headers['Authorization'] = 'Token $token';
  //   }, onError: (DioError e) async {
  //     if (e.type == DioErrorType.RESPONSE && e.response.statusCode == 401) {
  //       authenticationBloc.add(const TokenExpired());
  //     }
  //     return e;
  //   }));
  // }

  Future<void> deleteToken() async {
    await storage.delete(key: key);
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: key, value: token);
  }

  Future<bool> hasToken() async {
    final value = await storage.read(key: key);
    return value != null;
  }

  Future<Future<String?>> getToken() async {
    return storage.read(key: key);
  }

  // Future<void> deAuthenticate() async {
  //   final response = await dio.post(logoutUri);
  //   dio.interceptors.removeAt(dio.interceptors.length - 1);
  //   if (response.statusCode != 204) {
  //     throw const RequestApiError('Error logout');
  //   }
  // }
}
