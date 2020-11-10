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

  Future<Response> saveBooking(Map<String, dynamic> data) async {
    return dio.post('/booking/create', data: data, options: options);
  }
}