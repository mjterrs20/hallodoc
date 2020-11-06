import 'package:flutter/material.dart';
import 'package:hallodoc/ui/screens/service/servicePage.dart';
import 'package:intl/date_symbol_data_local.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // inisialisasi untuk date formating
    initializeDateFormatting('id_ID', null);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LayananPage(),
    );
  }
}
