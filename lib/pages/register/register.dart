import 'package:flutter/material.dart';
import 'package:hallodoc/models/ModelRegister.dart';
import 'package:hallodoc/utils/sharedPref.dart';
import 'package:hallodoc/widget/miscellaneous.dart';
import 'package:hallodoc/utils/colors.dart';
import 'package:dio/dio.dart';

PreferenceUtil appData = PreferenceUtil();

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true, _obscureCPassword = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  outFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
    HallodocWidget.loadingPageIndicator(context: context);
  }

  focusScope() {
    if (FocusNode() != null) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void savePrefences(String token) {
    appData.saveBoolVariable("login", true);
    appData.saveVariable("name", nameController.text);
    appData.saveVariable("email", emailController.text);
    appData.saveVariable("token", token);
  }

  void createAccount() async {
    // Response response;
    Dio dio = new Dio();
    try {
      Response response =
          await dio.post("http://35.188.140.28/api/register", data: {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "c_password": cPasswordController.text
      });
      print(response);
      var registerData = ModelRegister.fromJson(response.data);
      if (response.statusCode == 200 && registerData.success == true) {
        // Succes
        // Save Shared Pref
        savePrefences(registerData.data.token);
        Navigator.of(context).pop();
      } else {
        // Error Create
        Navigator.of(context).pop();
        HallodocWidget.hallodocDialog(
            context: context,
            title: 'Gagal',
            content: "Maaf Terjadi Kesalahan",
            buttons: <Widget>[
              HallodocWidget.hallodocButton(
                  buttonText: 'Ok',
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ]);
      }
    } catch (e) {
      // ketika error
      Navigator.of(context).pop();
      HallodocWidget.hallodocDialog(
          context: context,
          title: 'Gagal',
          content: "Maaf Terjadi Kesalahan",
          buttons: <Widget>[
            HallodocWidget.hallodocButton(
                buttonText: 'Ok',
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ]);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rgister")),
      body: GestureDetector(
        onTap: () {
          focusScope();
        },
        child: ListView(children: [
          Form(
            key: _formKey,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, bottom: 15, right: 15),
                      child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                              hintStyle: new TextStyle(
                                  color: Colors.grey[500],
                                  fontFamily: 'Comfortaa',
                                  fontSize: 16.0),
                              hintText: "Nama Lengkap",
                              fillColor: Colors.white70),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Tidak boleh kosong';
                            }
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, bottom: 15, right: 15),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                            hintStyle: new TextStyle(
                                color: Colors.grey[500],
                                fontFamily: 'Comfortaa',
                                fontSize: 16.0),
                            hintText: "example@gmail.com",
                            fillColor: Colors.white70),
                        validator: (value) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (value == '') {
                            return 'Tidak Boleh Kosong';
                          } else if (!regex.hasMatch(value)) {
                            print(value);
                            return 'Emalil Salah';
                          } else
                            return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, bottom: 15, right: 15),
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: new InputDecoration(
                            hintStyle: new TextStyle(
                                color: Colors.grey[500],
                                fontFamily: 'Comfortaa',
                                fontSize: 16.0),
                            hintText: "Password",
                            fillColor: Colors.white70,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              child: Icon(_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                        validator: (value) {
                          if (value.length < 6) {
                            return '6 karakter lebih';
                          } else if (value.toString() !=
                              cPasswordController.text) {
                            return 'Not Match';
                          }
                          return null;
                        },
                        obscureText: _obscurePassword,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, bottom: 15, right: 15),
                      child: TextFormField(
                        controller: cPasswordController,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            hintStyle: new TextStyle(
                                color: Colors.grey[500],
                                fontFamily: 'Comfortaa',
                                fontSize: 16.0),
                            hintText: "Ulangi Password",
                            fillColor: Colors.white70,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureCPassword = !_obscureCPassword;
                                });
                              },
                              child: Icon(_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                        validator: (value) {
                          if (value.length < 6) {
                            return '6 karakter lebih';
                          } else if (value.toString() !=
                              passwordController.text) {
                            return 'Not Match';
                          }
                          return null;
                        },
                        obscureText: _obscureCPassword,
                      ),
                    ),
                    // button create account
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                            elevation: 0.0,
                            color: TemaApp.greenColor,
                            textColor: Colors.white,
                            child: Text('Create',
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                if (passwordController.text ==
                                    cPasswordController.text) {
                                  // create
                                  outFocus();
                                  createAccount();
                                }
                              } else {
                                // jika masih ada data yang kosong
                              }
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      ),
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
