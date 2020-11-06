
import 'package:dio/dio.dart';

class Api {

  static const String baseUrl = "http://35.188.140.28/api/";

  static BaseOptions options = BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.plain,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    // ignore: missing_return
    validateStatus: (code) {
      if (code >= 200) {
        return true;
      }
    }
  );
}