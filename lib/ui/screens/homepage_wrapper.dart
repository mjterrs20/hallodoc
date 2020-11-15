// import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/ui/screens/auth/gate.dart';
import 'package:hallodoc/ui/screens/doctor/doctors.dart';
import 'package:hallodoc/ui/screens/home/homePage.dart';
import 'package:hallodoc/ui/screens/service/servicePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Project Package
import 'package:hallodoc/widget/miscellaneous.dart';
import 'package:provider/provider.dart';

class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: HomePageWrapper(),
    );
  }
}

class HomePageWrapper extends StatefulWidget {
  @override
  _HomePageWrapperState createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Map<String, dynamic> message = new Map<String, dynamic>();

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context).checkLogin();
    });
    configureFcm();
  }

  showNotifications(message) {
    return HallodocWidget.hallodocDialog(
        context: context,
        title: message['notification']['title'].toString() ?? "",
        content: message['notification']['body'].toString() ?? "",
        buttons: <Widget>[
          HallodocWidget.hallodocDialogButton(
              buttonText: 'Ya',
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ]);
  }

  void _navigateToItemDetail(message) {
    if (message.isNotEmpty) {
      // navigate to screen
    }
  }

  configureFcm() {
    _firebaseMessaging.configure(
      onMessage: (message) async {
        print(message.length.toString());
        showNotifications(message);
      },
      onLaunch: (message) async {
        _navigateToItemDetail(message);
        print(message);
      },
      onResume: (message) async {
        _navigateToItemDetail(message);
        print("onResume");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  Future<bool> _onWillPop() {
    return HallodocWidget.hallodocDialog(
            context: context,
            title: 'Keluar dari aplikasi',
            content: 'Apakah anda akan keluar dari aplikasi ?',
            buttons: <Widget>[
              HallodocWidget.hallodocDialogButton(
                  buttonText: 'Ya',
                  onPressed: () {
                    exit(0);
                  }),
              HallodocWidget.hallodocDialogButton(
                  buttonText: 'Tidak',
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ]) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
            child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'Beranda'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.building_2_fill), label: 'Layanan'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.calendar), label: 'Booking'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled), label: 'Akun'),
          ]),
          tabBuilder: (context, index) {
            if (index == 0) {
              return HomePage();
            } else if (index == 1) {
              return Layanans();
            } else if (index == 2) {
              return DoctorsPage();
            } else {
              return Gate();
              // return Consumer<AuthProvider>(
              //   builder: (context, data, _) {
              //     if(data.isLogin()) {
              //       return AboutPage(
              //       );
              //     }
              //     return Login();
              //   },
              // );
            }
          },
        )));
  }
}
