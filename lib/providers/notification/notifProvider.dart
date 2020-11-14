import 'dart:convert';
import 'package:hallodoc/models/notif.dart';
import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/notif/notifRepository.dart';

class NotifProvider extends BaseProvider {
  NotifResponse notifResponse;

  Future<void> fetchNotif(token) async {
    setLoading(true);
    await NotifRepository().notif(token).then((data) {
      if (data.statusCode == 200) {
        setNotifData(NotifResponse.fromJson(json.decode(data.data)));
        setLoading(false);
      } else {
        Map<String, dynamic> result = json.decode(data.data);
        setMessage(result.toString());
      }
    });
  }

  void setNotifData(value){
    notifResponse = value;
    notifyListeners();
  }

  NotifResponse getNotifData(){
    return notifResponse;
  }
}
