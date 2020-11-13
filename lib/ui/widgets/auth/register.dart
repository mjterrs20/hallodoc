import 'package:flutter/material.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<RegisterView> {

  final _formKey = GlobalKey<FormState>();
  String jenisKelamin = '';
  int selectedRadioJenKel;
  bool _obscurePassword = true,
      _obscureCPassword = true,
      checkJenisKelamin = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  setSelectedJenKel(int val) {
    setState(() {
      selectedRadioJenKel = val;
      if (val == 1) {
        jenisKelamin = "laki-laki";
      } else {
        jenisKelamin = "perempuan";
      }
    });
  }

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context).checkLogin();
    });
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
              Text("Maaf anda belum terdaftar dalam aplikasi."),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, bottom: 15, right: 15),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      hintStyle: new TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Poppins',
                          fontSize: 16.0),
                      hintText: "Nama Lengkap",
                      fillColor: Colors.white70),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                    return null;
                  }
                ),
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
                      print(value);
                      return 'Emalil Salah';
                    } else
                      return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, bottom: 10, right: 15),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: new InputDecoration(
                      hintStyle: new TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Poppins',
                          fontSize: 16.0),
                      hintText: "08XXX",
                      fillColor: Colors.white70),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Tidak boleh kosong';
                    } else if (value.length <= 10 || value.length >= 12) {
                      return 'Nomor Hp salah';
                    }
                    return null;
                  }
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
                          fontFamily: 'Poppins',
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
              // sex
              Padding(
                padding: EdgeInsets.only(bottom: 10, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: selectedRadioJenKel,
                          onChanged: (val) {
                            setSelectedJenKel(val);
                          },
                        ),
                        GestureDetector(
                          onTap: () => setSelectedJenKel(0),
                          child: new Text(
                            'Perempuan',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: selectedRadioJenKel,
                          onChanged: (val) {
                            setSelectedJenKel(val);
                          },
                        ),
                        GestureDetector(
                          onTap: () => setSelectedJenKel(1),
                          child: new Text(
                            'Laki-laki',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                    checkJenisKelamin == true
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Text("Harus diisi",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12)),
                          ),
                  ],
                ),
              ),
              // button create account
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Align(
                      child: 
                        data.isLoading() ?
                        CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 2,) :
                        Text('Daftar', style: TextStyle(color: Colors.white),),
                    ), onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        if (selectedRadioJenKel != null) {
                          if (passwordController.text ==
                            cPasswordController.text) {
                            Provider.of<AuthProvider>(context).register(
                              data: {
                                  "name": nameController.text,
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                  "c_password": cPasswordController.text,
                                  "phone": phoneController.text,
                                  "sex": jenisKelamin,
                              }
                            ).then((value) {
                              if(data.isCreated()) {
                                Provider.of<AuthProvider>(context).getProfile(
                                  data.getToken()
                                ).then((_) {
                                  if(data.isUserExist()) {
                                    print('berhasil get user');
                                    Provider.of<AuthProvider>(context).savePrefences(data.getToken());
                                    Provider.of<AuthProvider>(context).checkLogin();
                                  }
                                });
                              }
                            });
                          }
                        } else {
                          setState(() {
                            checkJenisKelamin = false;
                          });
                        }
                      } else {
                        // data null
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}