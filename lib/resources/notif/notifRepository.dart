import 'package:dio/dio.dart';
import 'package:hallodoc/resources/api.dart';

class NotifRepository {
  Dio dio = Dio(Api.options);
  RequestOptions options = RequestOptions(
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );

  Future<Response> notif(String token) async {
    options.headers['Authorization'] = 'Bearer $token';
    return dio.get('/user/notifications', options: options);
  }

  Future<Response> notifDetail(String token, int id) async {
    options.headers['Authorization'] = 'Bearer $token';
    return dio.get('/user/notifications/$id', options: options);
  }
  Future<Response> readNotif(String token, int id) async {
    options.headers['Authorization'] = 'Bearer $token';
    return dio.post('/user/notifications/$id/set-read', options: options);
  }
}
