import 'package:flutter/material.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/ui/screens/auth/login.dart';
import 'package:hallodoc/ui/screens/auth/profile.dart';
import 'package:provider/provider.dart';

class Gate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, data, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<AuthProvider>(context).checkLogin();
          });
          if(data == null) {
            print('null');
          }
          if(data.isLogin()) {
            return AboutPage();
          }
          return Login();
          
        },
      )
    );
  }
}