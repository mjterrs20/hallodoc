import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/providers/notification/notifProvider.dart';
import 'package:hallodoc/ui/screens/auth/login.dart';
import 'package:provider/provider.dart';

class Notif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotifProvider>(create: (_) => NotifProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, data, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<AuthProvider>(context).checkLogin();
          });
          if (data == null) {
            print('null');
          }
          if (data.isLogin()) {
            return NotifPage();
          }
          return Login();
        },
      ),
    );
  }
}

class NotifPage extends StatefulWidget {
  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context).checkToken();
      Future.delayed(Duration(milliseconds: 300), () {
        if (Provider.of<AuthProvider>(context).getToken() != null &&
            Provider.of<AuthProvider>(context).getToken().isNotEmpty) {
          Provider.of<NotifProvider>(context)
              .fetchNotif(Provider.of<AuthProvider>(context).getToken());
        }
      });
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      child: Consumer<NotifProvider>(
        builder: (context, data, _) {
          return ListTile(
            onTap: () {
              print(index.toString());
            },
            title: Text(data
                    .getNotifData()
                    .data
                    .notifications[index]
                    .title
                    .toString() ??
                ""),
            subtitle: Text(data
                    .getNotifData()
                    .data
                    .notifications[index]
                    .shortDesc
                    .toString() ??
                ""),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
        appBar: AppBar(title: Text("Notifikasi")),
        body: RefreshIndicator(
          onRefresh: _getData,
          child: Provider.of<NotifProvider>(context).isLoading()
              ? SingleChildScrollView(
                  child: Container(
                      height: ScreenUtil().screenHeight,
                      child: Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 2,
                      ))),
                )
              : Consumer<NotifProvider>(builder: (context, data, _) {
                  return ListView.builder(
                    itemCount: data.getNotifData() != null
                        ? data.getNotifData().data.notifications.length
                        : 0,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, index),
                  );
                }),
        ));
  }
}
