import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// Project Package
import 'package:hallodoc/utils/screenutil.dart';
import 'package:hallodoc/widget/miscellaneous.dart';
import 'package:hallodoc/widget/bottomnav.dart';
import 'package:hallodoc/pages/booking/booking.dart';
import 'package:hallodoc/pages/layanan/layanan.dart';
import 'package:hallodoc/pages/more/more.dart';
import 'package:hallodoc/pages/profile/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _myPage = PageController(initialPage: 0);
  int tabIndex = 0;

  void _selectedTab(tabIndex) {
    setState(() {
      _myPage.animateToPage(tabIndex,
          curve: Curves.easeInOutSine, duration: Duration(milliseconds: 500));
    });
  }

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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            MarBottomAppBar(
              centerItemText: 'Marbot',
              color: Colors.grey,
              iconSize: ScreenUtil().setSp(55),
              height: ScreenUtil().setHeight(125),
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: _selectedTab,
              items: [
                MarBottomAppBarItem(
                    iconData: Icons.home, text: 'Home'),
                MarBottomAppBarItem(
                    iconData: Icons.home, text: "Layanan"),
                MarBottomAppBarItem(
                    iconData: Icons.home,
                    text: 'Profile'),
                MarBottomAppBarItem(
                    iconData: Icons.home, text: 'More'),
              ],
            ),
          ],
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _myPage,
          onPageChanged: (int) {
            if (int == 0) {
              print('Page Changes to Beranda');
            } else if (int == 1) {
              print('Page Changes to Manasik');
            } else if (int == 2) {
              print('Page Changes to Transaksi');
            } else if (int == 0) {
              print('Page Changes to Akun Saya');
            }
          },
          children: <Widget>[
            LayananPage(),
            BookingPage(),
            ProfilePage(),
            MorePage(),
          ],
        ),
      ),
    );
  }
}
