import 'package:dio/dio.dart';
import 'package:flutter_application_1/network/response/get_user_response.dart';
import 'package:flutter_application_1/network/response/login_response.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<LoginResponse> login(String email, String password) async {
    try {
      Response response = await _dio.post('https://reqres.in/api/login',
          data: {'email': email, 'password': password},
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ));
      if (response.statusCode == 200) {
        //returns the successful user data json object
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  Future<GetUserResponse> getUserInfo(String accesstoken) async {
    try {
      Response response = await _dio.get(
        'https://reqres.in/api/users?page=2',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accesstoken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        //returns the successful user data json object
        return GetUserResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get users');
      }
    } on DioException catch (e) {
      return e.response!.data;
    }
  }
}
