import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project Package
import 'package:hallodoc/utils/screenutil.dart';
import 'package:hallodoc/widget/miscellaneous.dart';
import 'package:hallodoc/pages/home/home.dart';
import 'package:hallodoc/widget/bottomnav.dart';
import 'package:hallodoc/pages/booking/booking.dart';
import 'package:hallodoc/pages/layanan/layanan.dart';
import 'package:hallodoc/pages/profile/profile.dart';

class HomePageWrapper extends StatefulWidget {
  @override
  _HomePageWrapperState createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
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
    ScreenUtil.instance = ScreenUtil(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      allowFontScaling: true,
    )..init(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            MarBottomAppBar(
              color: Colors.grey,
              iconSize: ScreenUtil().setSp(55),
              height: ScreenUtil().setHeight(125),
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: _selectedTab,
              items: [
                MarBottomAppBarItem(iconData: Icons.home, text: 'Home'),
                MarBottomAppBarItem(
                  iconData: Icons.room_service,
                  text: "Layanan",
                ),
                MarBottomAppBarItem(
                    iconData: Icons.calendar_today, text: 'Booking'),
                MarBottomAppBarItem(
                    iconData: Icons.account_box, text: 'Profile'),
              ],
            ),
          ],
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _myPage,
          children: <Widget>[
            HomePage(),
            LayananPage(),
            BookingPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
