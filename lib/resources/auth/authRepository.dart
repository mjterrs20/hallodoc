import 'package:dio/dio.dart';
import 'package:hallodoc/resources/api.dart';

class AuthRepository {

  Dio dio = Dio(Api.options);
  RequestOptions options = RequestOptions(
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );

  Future<Response> register(Map<String, dynamic> data) async {
    return dio.post('/register', data: data, options: options);
  }

  Future<Response> login(Map<String, dynamic> data) async {
    print(data);
    return dio.post('/login', data: data, options: options);
  }

  Future<Response> getProfile(String token) async {
    options.headers['Authorization'] = 'Bearer $token';
    return dio.post('/user', options: options);
  }
}