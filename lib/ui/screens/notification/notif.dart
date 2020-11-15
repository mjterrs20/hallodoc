import 'package:flutter/material.dart';
import 'package:hallodoc/models/notif.dart';
import 'package:hallodoc/ui/screens/notification/notifDetail.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/providers/notification/notifProvider.dart';
import 'package:hallodoc/ui/screens/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';

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
  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
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

  redirect(int id) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotifDetail(id: id),
        ));
    _getData();
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      child: Consumer<NotifProvider>(
        builder: (context, data, _) {
          Notifications dat = data.getNotifData().data.notifications[index];
          return InkWell(
            onTap: () async {
              Provider.of<NotifProvider>(context).readNotifDetail(
                  Provider.of<AuthProvider>(context).getToken(), dat.id);
              redirect(dat.id);
              // var result = await Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => NotifDetail(id: dat.id),
              //     ));
              // print(result);
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        width: 65,
                        height: 65,
                        child: Center(
                          child: Text(
                            camelize(dat.tag.toString().toLowerCase()) ?? "",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10),
                            child: Text(
                              dat.title.toString() ?? "",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            child: Text(
                              dat.shortDesc.toString() ?? "",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.alarm,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  Center(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          dateFormat
                                              .format(DateTime.parse(dat.date)),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300,
                                            color: Colors.grey,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                        ])),
                    dat.hasRead == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 7,
                            ),
                          )
                        : Container(width: 1),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 15),
                      child: Icon(Icons.navigate_next),
                    )
                  ],
                ),
                Divider(
                  height: 1,
                ),
              ],
            ),
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
