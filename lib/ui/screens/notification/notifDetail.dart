import 'package:flutter/material.dart';
import 'package:hallodoc/models/notif.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/providers/notification/notifProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';

class NotifDetail extends StatelessWidget {
  final int id;

  NotifDetail({@required this.id});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotifProvider>(create: (_) => NotifProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: NotifDelaitPage(id: id),
    );
  }
}

class NotifDelaitPage extends StatefulWidget {
  final int id;

  NotifDelaitPage({@required this.id});
  @override
  _NotifDelaitPageState createState() => _NotifDelaitPageState();
}

class _NotifDelaitPageState extends State<NotifDelaitPage> {
  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
  DataNotif dat;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context).checkToken();
      Future.delayed(Duration(milliseconds: 500), () {
        if (Provider.of<AuthProvider>(context).getToken() != null &&
            Provider.of<AuthProvider>(context).getToken().isNotEmpty) {
          Provider.of<NotifProvider>(context).fetchNotifDetail(
              Provider.of<AuthProvider>(context).getToken(), widget.id);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Notif")),
      body: Consumer<NotifProvider>(builder: (context, data, _) {
        if (!data.notifDetailExist()) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 2,
          ));
        }
        dat = data.getNotifDetail().data;
        return ListView(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dat.imageUrl != null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: FadeInImage.assetNetwork(
                            fadeInCurve: Curves.linear,
                            placeholder: 'assets/images/banner_placeholder.png',
                            fit: BoxFit.fill,
                            image: dat.imageUrl,
                            width: MediaQuery.of(context).size.width,
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                    child: Text(
                      dat.title ?? "",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                    child: Container(
                      child: Text(
                        camelize(dat.tag.toLowerCase()),
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                                  dateFormat.format(DateTime.parse(dat.date)),
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
                  Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Text(
                        dat.contentText,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      )),
                ]),
          ],
        );
      }),
    );
  }
}
