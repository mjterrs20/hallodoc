import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/ui/screens/homepage_wrapper.dart';
import 'package:hallodoc/widget/miscellaneous.dart';
import 'package:provider/provider.dart';

class SplashApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) {
        return AuthProvider();
      },
      child: Splashscreen(),
    );
  }
}

class Splashscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  bool showLoading = false;

  startTime() async {
    var _duration = new Duration(milliseconds: 2500);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context).checkToken();
      Future.delayed(Duration(milliseconds: 300), () {
        if(Provider.of<AuthProvider>(context).getToken() != null && Provider.of<AuthProvider>(context).getToken().isNotEmpty) {
          Provider.of<AuthProvider>(context).validate(
            Provider.of<AuthProvider>(context).getToken()
          ).then((value) {
            if(!Provider.of<AuthProvider>(context).isAuthenticated()) {
              Provider.of<AuthProvider>(context).logout();
            }
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeWrapper()));
          }).catchError((onError) {
            Provider.of<AuthProvider>(context).logout();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeWrapper()));
          });
        } else {
         Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeWrapper()));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 3000,
      ),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    );
    animationController.forward();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        showLoading = true;
      });
    });
    startTime();
  }

  @override
  void dispose() {
    animationController.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: ScaleTransition(
              scale: animation,
              child: Container(
                  height: ScreenUtil().setHeight(200),
                  width: ScreenUtil().setWidth(200),
                  child: Image.asset('assets/icons/maki_doctor-11.png', color: Colors.blue),),
            ),
          ),
          showLoading
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      height: 85,
                      child: HallodocWidget.loadingData(),
                    ),
                  )
              : Center(
                  child: Container(
                    height: 35,
                    width: 35,
                  ),
                )
        ],
      )),
    );
  }
}
