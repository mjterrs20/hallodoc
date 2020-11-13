import 'package:dio/dio.dart';
import 'package:hallodoc/resources/api.dart';

class BookingRepository {

  Dio dio = Dio(Api.options);
  RequestOptions options = RequestOptions(
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );

  Future<Response> saveBooking(Map<String, dynamic> data, token) async {
    options.headers['Authorization'] = 'Bearer $token';
    return dio.post('/booking/create', data: data, options: options);
  }

  Future<Response> getAllBooking(token) async {
    options.headers['Authorization'] = 'Bearer $token';
    return dio.get('/bookings', options: options);
  }

  Future<Response> getBooking(id, token) async {
    options.headers['Authorization'] = 'Bearer $token';
    return dio.get('/booking/$id', options: options);
  }
}