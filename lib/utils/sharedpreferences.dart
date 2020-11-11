import 'package:shared_preferences/shared_preferences.dart';
class PreferenceUtil {
  checkLogin() async {
    bool _login = false;
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _login = (prefs.getBool('isLogin') ?? false);
    //_login = true;
    return _login;
  }
  // Logout
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    // prefs.setString('store_name', "-");
    // prefs.setString('store_id', "-");
  }

  getName() async {
    String _name;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = (prefs.getString('name'));
    prefs.setString('name', _name);
    return _name;
  }

  getEmail() async {
    String _email;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email'));
    prefs.setString('email', _email);
    return _email;
  }
  getPhone() async {
    String _phone;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _phone = (prefs.getString('phone'));
    prefs.setString('phone', _phone);
    return _phone;
  }

  getSex() async {
    String _sex;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _sex = (prefs.getString('sex'));
    prefs.setString('sex', _sex);
    return _sex;
  }

  getToken() async {
    String _token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = (prefs.getString('token'));
    prefs.setString('token', _token);
    return _token;
  }

  getRole() async {
    String _role;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _role = (prefs.getString('role'));
    prefs.setString('role', _role);
    return _role;
  }

  // Mengambil variable general (untuk passing parameter)
  getVariable(String namaVariable) async {
    String _valueVariable;
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _valueVariable = (prefs.getString(namaVariable));
    return _valueVariable; 
  }

  // Mengambil variable general (untuk passing parameter)
  getIntVariable(String namaVariable) async {
    int _valueVariable;
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _valueVariable = (prefs.getInt(namaVariable));
    return _valueVariable; 
  }

  // Mengambil variable general (untuk passing parameter)
  getBoolVariable(String namaVariable) async {
    bool _valueVariable;
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    _valueVariable = (prefs.getBool(namaVariable));
    return _valueVariable; 
  }

  // Menyimpan variable general (untuk passing parameter)
  saveVariable(String namaVariable, String valueVariable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(namaVariable, valueVariable);
  }

  // Menyimpan variable general (untuk passing parameter)
  saveIntVariable(String namaVariable, int valueVariable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(namaVariable, valueVariable).then((value) => print('selected'));
  }

  // Menyimpan variable general (untuk passing parameter)
  saveBoolVariable(String namaVariable, bool valueVariable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(namaVariable, valueVariable);
  }

  // Menyimpan variable general (untuk passing parameter)
  destroyVariable(String namaVariable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(namaVariable);
  }

} 