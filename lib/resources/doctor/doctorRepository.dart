import 'package:dio/dio.dart';
import 'package:hallodoc/resources/api.dart';

class DoctorRepository {

  Dio dio = Dio(Api.options);
  RequestOptions options = RequestOptions(
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );

  Future<Response> getDoctors() async {
    return dio.get('/doctor/list', options: options);
  }

  Future<Response> getDoctor({String id}) async {
    return dio.get('/doctor/$id', options: options);
  }
}