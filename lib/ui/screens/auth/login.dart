import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/ui/widgets/auth/login.dart';
import 'package:hallodoc/ui/widgets/auth/register.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: _LoginPageFul(),
    );
  }
}


class _LoginPageFul extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<_LoginPageFul> {

  bool buildLogin = true;

  void changeUi(value) {
    setState(() {
      buildLogin = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(buildLogin ? "Masuk" : "Daftar"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<AuthProvider>(
                builder: (context, data, _) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: buildLogin ? 
                          LoginView() : 
                          RegisterView(),
                  );
                },
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: buildLogin ?'Belum punya akun?' : "Sudah punya akun?",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        children: <TextSpan>[
                      TextSpan(
                          text: buildLogin ? ' Daftar' : " Masuk",
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 18),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              buildLogin ? changeUi(false) : changeUi(true);
                            })
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}