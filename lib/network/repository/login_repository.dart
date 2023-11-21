import 'package:flutter_application_1/network/api_client.dart';
import 'package:flutter_application_1/network/response/login_response.dart';

class LoginRepository {
  ApiClient _apiClient = ApiClient();

  Future<LoginResponse> login(String email, String password) {
    return _apiClient.login(email, password);
  }
}
