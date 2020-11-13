import 'dart:convert';

import 'package:flutter_dialogflow/flutter_dialogflow.dart';
import 'package:hallodoc/models/auth.dart';
import 'package:hallodoc/models/user.dart';
import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/auth/authRepository.dart';
import 'package:hallodoc/utils/sharedpreferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthProvider extends BaseProvider {
  Auth auth;
  UserResponse user;
  bool _created = false;
  bool _login = false;
  String name, email, phone, deviceToken;

  PreferenceUtil appData = PreferenceUtil();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<void> register({Map<String, dynamic> data}) async {
    setLoading(true);
    await AuthRepository().register(data).then((response) {
      setLoading(false);
      if (response.statusCode == 200) {
        setToken(Auth.fromJson(json.decode(response.data)));
        setCreated(true);
      } else {
        Map<String, dynamic> result = json.decode(response.data);
        setError(true);
        setMessage(result['error'].toString());
      }
    });
  }

  Future<void> login({Map<String, dynamic> data}) async {
    setLoading(true);
    await AuthRepository().login(data).then((response) {
      setLoading(false);
      if (response.statusCode == 200) {
        print(json.decode(response.data));
        setToken(Auth.fromJson(json.decode(response.data)));
        setCreated(true);
      } else {
        Map<String, dynamic> result = json.decode(response.data);
        setError(true);
        print(json.decode(response.data));
        setMessage(result['error'].toString());
      }
    });
  }

  Future<void> getProfile(token) async {
    setLoading(true);
    await AuthRepository().getProfile(token).then((response) {
      setLoading(false);
      if (response.statusCode == 200) {
        print(json.decode(response.data));
        setUser(UserResponse.fromJson(json.decode(response.data)));
      } else {
        Map<String, dynamic> result = json.decode(response.data);
        setError(true);
        setMessage(result['message'].toString());
      }
    });
  }

  void checkLogin() {
    appData.checkLogin().then((result) {
      setLogin(result);
    });
    notifyListeners();
  }

  void setLogin(value) {
    _login = value;
    notifyListeners();
  }

  bool isLogin() {
    return _login;
  }

  void savePrefences(String token) {
    try {
      print(user.user.name);
      appData.saveBoolVariable("isLogin", true);
      appData.saveVariable("name", user.user.name);
      appData.saveVariable("email", user.user.email);
      appData.saveVariable("token", token);
      appData.saveVariable("phone", user.user.phone);
      appData.saveVariable("role", user.user.isDoctor ? 'doctor' : 'patient');
      appData.saveVariable("sex", user.user.sex);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  void logout() {
    appData.logout();
    setLogin(false);
    notifyListeners();
  }

  void setCreated(value) {
    _created = value;
    notifyListeners();
  }

  bool isTokenExist() {
    print('token ada');
    return auth != null && auth.data.token != null;
  }

  bool isCreated() {
    return _created;
  }

  void getDeviceToken() async {
    _firebaseMessaging.getToken().then((value) => setDeviceToken(value));
    notifyListeners();
  }

  void setDeviceToken(value) {
    deviceToken = value;
    print(deviceToken);
    notifyListeners();
  }

  void setToken(value) {
    auth = value;
    notifyListeners();
  }

  String getToken() {
    return auth.data.token;
  }

  void setUser(value) {
    user = value;
    notifyListeners();
  }

  User getUser() {
    return user.user;
  }

  bool isUserExist() {
    return user != null && user.user != null;
  }

  bool isPatient() {
    return user.user.isPatient;
  }

  bool isDoctor() {
    return user.user.isDoctor;
  }

  String getName() {
    appData.getVariable("name").then((result) {
      name = result;
    });
    return name;
  }

  String getEmail() {
    appData.getVariable("email").then((result) {
      email = result;
    });
    return email;
  }

  String getPhone() {
    appData.getVariable("phone").then((result) {
      phone = result;
    });
    return phone;
  }
}
