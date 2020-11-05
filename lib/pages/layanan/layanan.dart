import 'package:flutter/material.dart';
import 'package:hallodoc/utils/sharedPref.dart';

PreferenceUtil appData = PreferenceUtil();

class LayananPage extends StatefulWidget {
  @override
  _LayananPageState createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  String name = "";
  @override
  void initState() {
    super.initState();
    appData.getVariable("name").then((result) {
      if (result != null) {
        setState(() {
          name = result;
          print(name);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Layanan")),
    );
  }
}
