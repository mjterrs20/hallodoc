import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:hallodoc/ui/screens/home/homePage.dart';
import 'package:hallodoc/ui/screens/service/servicePage.dart';

// Project Package
import 'package:hallodoc/widget/miscellaneous.dart';
import 'package:hallodoc/widget/bottomnav.dart';
import 'package:hallodoc/pages/booking/booking.dart';
import 'package:hallodoc/pages/profile/profile.dart';

class HomePageWrapper extends StatefulWidget {
  @override
  _HomePageWrapperState createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {

  @override
  void setState(fn) {
    super.setState(fn);
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
    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Beranda'
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.building_2_fill),
              label: 'Layanan'
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar),
              label: 'Booking'
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Akun'
            ),
          ]),
          tabBuilder: (context, index) {
            if (index == 0) {
              return HomePage();
            } else if (index == 1) {
              return Layanans();
            } else if (index == 2) {
              return BookingPage();
            } else {
              return ProfilePage();
            }
          },
        )
      )
    );
  }
}
