
import 'package:flutter/material.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/utils/sharedpreferences.dart';
import 'package:hallodoc/widget/miscellaneous.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

PreferenceUtil appData = new PreferenceUtil();

class _State extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context).checkLogin();
    });
  }

  showDialog(content) {
    return HallodocWidget.hallodocDialog(
      context: context,
      title: "Maaf",
      content: content,
      buttons: <Widget>[
        HallodocWidget.hallodocDialogButton(
          buttonText: 'Ya',
          onPressed: () {
            Navigator.pop(context);
          }),
      ]);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Consumer<AuthProvider>(
          builder: (context, data, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Silahkan login untuk menikmati semua fitur dari Halodoc"),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                        hintStyle: new TextStyle(
                            color: Colors.grey[500],
                            fontFamily: 'Poppins',
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
                        return 'Emalil Salah';
                      } else
                        return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: new InputDecoration(
                        hintStyle: new TextStyle(
                            color: Colors.grey[500],
                            fontFamily: 'Poppins',
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
                      return null;
                    },
                    obscureText: _obscurePassword,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        child: data.isLoading()
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                strokeWidth: 2,
                              )
                            : Text(
                                'Masuk',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Provider.of<AuthProvider>(context).login(data: {
                            "email": emailController.text,
                            "password": passwordController.text,
                          }).then((value) {
                            if (data.isCreated()) {
                              Provider.of<AuthProvider>(context)
                                  .getProfile(data.getToken())
                                  .then((_) {
                                if (data.isUserExist()) {
                                  print('berhasil get user');
                                  if (data.getToken().isNotEmpty) {
                                    print('token ada');
                                    Provider.of<AuthProvider>(context)
                                        .savePrefences(data.getToken());
                                    Provider.of<AuthProvider>(context)
                                        .checkLogin();
                                  } else {
                                    showDialog("Terjadi kesalahan, silahkan coba lagi nanti");
                                    print('token ga ada');
                                  }
                                } else {
                                  showDialog("Terjadi kesalahan, silahkan coba lagi nanti");
                                }
                              });
                            } else {
                              showDialog("Terjadi kesalahan, silahkan coba lagi nanti");
                            }
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
