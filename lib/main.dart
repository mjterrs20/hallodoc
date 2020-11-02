import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Packages
import 'package:hallodoc/pages/home.dart';
import 'package:hallodoc/pages/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

// Use green color
const MaterialColor primarySwatchColor = const MaterialColor(
  0xFFB60000,
  const <int, Color>{
    50: const Color(0xFFB60000),
    100: const Color(0xFFB60000),
    200: const Color(0xFFB60000),
    300: const Color(0xFFB60000),
    400: const Color(0xFFB60000),
    500: const Color(0xFFB60000),
    600: const Color(0xFFB60000),
    700: const Color(0xFFB60000),
    800: const Color(0xFFB60000),
    900: const Color(0xFFB60000),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          // '/home': (BuildContext context) => HomePage(),
        });
  }
}
