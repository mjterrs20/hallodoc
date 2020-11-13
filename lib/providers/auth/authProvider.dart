import 'dart:convert';

import 'package:hallodoc/models/auth.dart';
import 'package:hallodoc/models/user.dart';
import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/auth/authRepository.dart';
import 'package:hallodoc/utils/sharedpreferences.dart';

class AuthProvider extends BaseProvider {

  Auth auth;
  UserResponse user;
  bool _created = false;
  bool _login = false;
  bool _authenticated = false;

  String _userID;
  String _token;

  PreferenceUtil appData = PreferenceUtil();

  Future<void> register({Map<String, dynamic> data}) async {
    setLoading(true);
    await AuthRepository().register(data).then((response) {
      setLoading(false);
      if (response.statusCode == 200) {
        setToken(Auth.fromJson(json.decode(response.data)).data.token);
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
        setToken(Auth.fromJson(json.decode(response.data)).data.token);
        setCreated(true);
      } else {
        Map<String, dynamic> result = json.decode(response.data);
        setError(true);
        setMessage(result['error'].toString());
      }
    });
  }

  Future<void> getProfile(token) async {
    setLoading(true);
    await AuthRepository().getProfile(token).then((response) {
      setLoading(false);
      if (response.statusCode == 200) {
        setUser(UserResponse.fromJson(json.decode(response.data)));
      } else {
        Map<String, dynamic> result = json.decode(response.data);
        setError(true);
        setMessage(result['message'].toString());
      }
    });
  }

  Future<void> validate(token) async {
    setLoading(true);
    await AuthRepository().validate(token).then((response) {
      setLoading(false);
      if (response.statusCode == 200) {
        print(json.decode(response.data));
        setUnauthenticated(true);
        setMessage(json.decode(response.data)['data']);
      } else {
        setUnauthenticated(false);
        print(json.decode(response.data));
        setMessage(json.decode(response.data)['data']);
      }
    });
  }

  setUnauthenticated(value) {
    _authenticated = value;
    notifyListeners();
  }

  isAuthenticated() {
    return _authenticated == true;
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
    return _login == true;
  }

  void checkUserId() {
    appData.getVariable("id").then((result) {
      setUserId(result);
    });
    notifyListeners();
  }

  checkToken() {
    appData.getVariable("token").then((result) {
      setToken(result);
    });
    notifyListeners();
  }

  void setUserId(value) {
    _userID = value;
    notifyListeners();
  }

  String getUserId() {
    return _userID;
  }

  void savePrefences(String token) {
    try {
      appData.saveBoolVariable("isLogin", true);
      appData.saveVariable("id", user.user.id.toString());
      appData.saveVariable("name", user.user.name);
      appData.saveVariable("email", user.user.email);
      appData.saveVariable("token", token);
      appData.saveVariable("phone", user.user.phone);
      appData.saveVariable("role", user.user.isDoctor ? 'doctor' : 'patient');
      appData.saveVariable("sex", user.user.sex);
    } catch(e) {
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
    return _token != null && _token.isNotEmpty;
  }

  bool isCreated() { 
    return _created;
  }

  void setToken(value) {
    _token = value;
    notifyListeners();
  }

  String getToken() { 
    return _token;
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
}