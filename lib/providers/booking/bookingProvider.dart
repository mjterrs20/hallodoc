import 'dart:convert';

import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/booking/bookingRepository.dart';

class BookingProvider extends BaseProvider {

  bool _created = false;

  Future<void> fetchDoctor({Map<String, dynamic> data}) async {
    setLoading(true);
    await BookingRepository().saveBooking(data).then((response) {
      setLoading(false);
      if (response.statusCode == 200) {
        setCreated(true);
      } else {
        Map<String, dynamic> result = json.decode(response.data);
        setError(true);
        setMessage(result['message'].toString());
      }
    });
  }

  void setCreated(value) {
    _created = value;
    notifyListeners();
  }

  bool isCreated() { 
    return _created;
  }
}