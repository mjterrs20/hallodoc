import 'dart:convert';
import 'package:hallodoc/models/notif.dart';
import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/notif/notifRepository.dart';

class NotifProvider extends BaseProvider {
  NotifResponse notifResponse;
  NotifDetailResponse notifDetailResponse;
  int _countHasRead = 0;

  Future<void> fetchNotif(token) async {
    setLoading(true);
    await NotifRepository().notif(token).then((data) {
      if (data.statusCode == 200) {
        setNotifData(NotifResponse.fromJson(json.decode(data.data)));
        setLoading(false);
        countReadNotif();
      } else {
        Map<String, dynamic> result = json.decode(data.data);
        setMessage(result.toString());
      }
    });
  }

  Future<void> fetchNotifDetail(token, id) async {
    setLoading(true);
    await NotifRepository().notifDetail(token, id).then((data) {
      if (data.statusCode == 200) {
        setNotifDetail(NotifDetailResponse.fromJson(json.decode(data.data)));
        setLoading(false);
      } else {
        Map<String, dynamic> result = json.decode(data.data);
        setMessage(result.toString());
      }
    });
  }

  Future<void> readNotifDetail(token, id) async {
    await NotifRepository().readNotif(token, id).then((data) {
      if (data.statusCode == 200) {
        Map<String, dynamic> result = json.decode(data.data);
        setMessage(result.toString());
      } else {
        Map<String, dynamic> result = json.decode(data.data);
        setMessage(result.toString());
      }
    });
  }

  countReadNotif(){
    int count = 0;
    var data = notifResponse.data.notifications;
    for (int i = 0; i < data.length; i++){
      if (data[i].hasRead == 0){
        count++;
      }
    }  
    setCountNotif(count);
  }

  void setNotifData(value) {
    notifResponse = value;
    notifyListeners();
  }

  NotifResponse getNotifData() {
    return notifResponse;
  }

  void setNotifDetail(value) {
    notifDetailResponse = value;
    notifyListeners();
  }

  NotifDetailResponse getNotifDetail() {
    return notifDetailResponse;
  }

  bool notifDetailExist() {
    return notifDetailResponse != null;
  }

  int getCountNotif(){
    return _countHasRead;
  }
  void setCountNotif(value) {
    _countHasRead = value;
    notifyListeners();
  }

}
