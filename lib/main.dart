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
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
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
          fontFamily: 'Poppins',
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black
            ),
            color: Color(0xFFFFFFFF),
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.black,
                fontSize: 19.0,
              )
            ),
          ),
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0),
          ),
        ),
        initialRoute: '/',
        home: HomePageWrapper(),
        routes: <String, WidgetBuilder>{
          // '/home': (BuildContext context) => HomePage(),
        });
  }
}
