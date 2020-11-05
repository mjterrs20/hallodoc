import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hallodoc/pages/splashscreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
          child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/register');
        },
        child: Text("Register"),
        color: Colors.red,
      )),
    );
  }
}
