import 'package:flutter/material.dart';
import 'package:hallodoc/ui/screens/service/servicePage.dart';
import 'package:intl/date_symbol_data_local.dart'; 
import 'package:flutter/services.dart';

// Packages
import 'package:hallodoc/pages/home/home.dart';
import 'package:hallodoc/pages/homepage_wrapper.dart';
import 'package:hallodoc/pages/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

// Use green color
const MaterialColor primarySwatchColor = const MaterialColor(
  0xFF64BE4F,
  const <int, Color>{
    50: const Color(0xFF64BE4F),
    100: const Color(0xFF64BE4F),
    200: const Color(0xFF64BE4F),
    300: const Color(0xFF64BE4F),
    400: const Color(0xFF64BE4F),
    500: const Color(0xFF64BE4F),
    600: const Color(0xFF64BE4F),
    700: const Color(0xFF64BE4F),
    800: const Color(0xFF64BE4F),
    900: const Color(0xFF64BE4F),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // inisialisasi untuk date formating
    initializeDateFormatting('id_ID', null);
    return MaterialApp(
        title: 'Hallodoc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //handle copy paste texfield mazlines:null
          buttonTheme: ButtonThemeData(minWidth: 10),
          fontFamily: 'Comfortaa',
          primarySwatch: primarySwatchColor,
        ),
        initialRoute: '/',
        home: HomePageWrapper(),
        routes: <String, WidgetBuilder>{
          // '/home': (BuildContext context) => HomePage(),
        });
  }
}
