import 'package:dio/dio.dart';
import 'package:hallodoc/resources/api.dart';

class ContentRepository {

  Dio dio = Dio(Api.options);

  Future<Response> getContent({String filter}) async {
    String endPoint = "/content";
    if (filter != null && filter.isNotEmpty) {
      endPoint += filter;
    }
    RequestOptions options = RequestOptions(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    return dio.get(endPoint, options: options);
  }
}