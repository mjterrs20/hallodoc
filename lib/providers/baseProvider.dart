import 'package:flutter/foundation.dart';

class BaseProvider extends ChangeNotifier {
  String errorMessage;
  bool loading = false;

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  } 

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() { 
    return loading;
  }
}