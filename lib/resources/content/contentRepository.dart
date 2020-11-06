import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hallodoc/models/content.dart';
import 'package:hallodoc/resources/api.dart';

class ContentRepository {

  Dio dio = Dio(Api.options);

  Future<dynamic> getContent({String filter}) async {
    String endPoint = "/content";
    if (filter != null && filter.isNotEmpty) {
      endPoint += filter;
    }
    try {
      RequestOptions options = RequestOptions(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      Response response = await dio.get(endPoint, options: options);
      return Content.fromJson(jsonDecode(response.data));
    }
    catch(e) {
      print(e.toString());
    }
  }

}