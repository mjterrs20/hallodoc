import 'package:dio/dio.dart';
import 'package:hallodoc/resources/api.dart';

class HospitalRepository {

  Dio dio = Dio(Api.options);
  RequestOptions options = RequestOptions(
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );

  Future<Response> getHospitals() async {
    return dio.get('department/1/hospitals', options: options);
  }

  Future<Response> getHospital({String id}) async {
    return dio.get('department/1/hospital/$id', options: options);
  }
}