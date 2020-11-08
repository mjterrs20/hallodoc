import 'dart:convert';

import 'package:hallodoc/models/content.dart';
import 'package:hallodoc/providers/content/baseContentProvider.dart';
import 'package:hallodoc/resources/content/contentRepository.dart';

class ContentProvider extends BaseContentProvider {

  Future<bool> fetchContent({String query}) async {
    setLoading(true);

    await ContentRepository().getContent(filter: query).then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        setContent(Content.fromJson(json.decode(data.data)));
      } else {
        Map<String, dynamic> result = json.decode(data.data);
        setMessage(result.toString());
      }
    });
    return isExist();
  }
}