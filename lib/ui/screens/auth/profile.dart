import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hallodoc/models/user.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/ui/screens/booking/history.dart';
import 'package:hallodoc/ui/screens/doctor/doctors.dart';
import 'package:hallodoc/ui/screens/home/about.dart';
import 'package:hallodoc/ui/screens/home/feedback.dart';
import 'package:hallodoc/ui/screens/service/partnerandCareer.dart';
import 'package:hallodoc/ui/widgets/views/circleImage.dart';
import 'package:hallodoc/widget/miscellaneous.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: AboutScreen(),
    );
  }
}


class AboutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutScreenState();
  }
}

class _AboutScreenState extends State<AboutScreen> {

  int userId;
  String docId;

  AuthProvider mainProvider;

  File _image;
  String detik = '';
  DateTime _tanglah = DateTime.now();
  String filename = '', foto = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context).checkLogin();
      Provider.of<AuthProvider>(context).checkToken();
      Future.delayed(Duration(milliseconds: 300), () {
        Provider.of<AuthProvider>(context).getProfile(
          Provider.of<AuthProvider>(context).getToken()
        );
      });
    });
  }

  void _showDialogLogout(context, AuthProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return DialogLogout();
      },
    );
  }

  void showImageDialog(bool isEnabled) {
    if(!isEnabled) {
      return showDialogText("Fitur masih dalam tahap pengembangan");
    }
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      builder: (builder) {
        return Container(
          height: 250.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: 40.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0, left: 20.0, bottom: 30.0),
                child: Text(
                  "Foto Profil",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _getImage(context, ImageSource.camera);
                },
                leading: Icon(Icons.photo_camera),
                title: Text(
                  "Ambil Foto dari Kamera",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  _getImage(context, ImageSource.gallery);
                },
                leading: Icon(Icons.photo_library),
                title: Text(
                  "Ambil Foto dari Galeri",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future _getImage(BuildContext context, ImageSource source) async {
    final selectedImage = await ImagePicker.pickImage(source: source);
    if (selectedImage != null) {
      setState(() {
        detik = DateFormat("hhmmss").format(_tanglah).toString();
        _image = File(selectedImage.path);
        filename = detik + "foto_user.jpg";
      });
      Navigator.pop(context); 
      print(_image);
    } 
    Navigator.pop(context);
  }

  showDialogText(content) {
    return HallodocWidget.hallodocDialog(
      context: context,
      title: "Maaf",
      content: content,
      buttons: <Widget>[
        HallodocWidget.hallodocDialogButton(
          buttonText: 'Ya',
          onPressed: () {
            Navigator.pop(context);
          }),
      ]);
  }

  Widget _buildListItem(BuildContext context) {
    return Container(
      child: Consumer<AuthProvider>(
        builder: (context, data, _) {
          if(!data.isUserExist()) {
            return Container(
              height: ScreenUtil().screenHeight,
              child: Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
                strokeWidth: 2,
              )),
            );
          }
          User user = data.getUser();
          return Column(
            children: <Widget>[
            Container(
              height: 260.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home_ilustration.png'),
                  colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(.6), BlendMode.srcOver),
                  fit: BoxFit.cover
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  user.imageUrl == null ?
                  ClipOval(
                    child: Image.asset(
                            'assets/images/home_ilustration.png',
                            width: 120,
                            height: 120,
                          )
                  ): CircleImage(height: 
                  120, url: user.imageUrl, width: 120),
                  GestureDetector(
                    onTap: () {
                      showImageDialog(false);
                    },
                    child: Container(
                      width: 40,
                      height: 18,
                      margin: EdgeInsets.only(top: 8.0, bottom: 5.0),
                      child: Center(
                        child: Text(
                          "Ganti",
                          style: TextStyle(
                            fontSize: 10.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 2.0),
                    child: Text(
                      user.id.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.0, bottom: 5.0),
                    child: Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      user.phone,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => WebViewPage(
                            url: "https://pikobar.jabarprov.go.id/",
                            title: "Informasi Covid-19",
                          )
                        )
                      );
                    },
                    leading: Icon(FontAwesomeIcons.virus),
                    title: Text(
                      "Informasi Covid-19",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Divider(
                    height: 0.0,
                    color: Colors.grey,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => BookingHistoryPage()
                        )
                      );
                    },
                    leading: Icon(FontAwesomeIcons.calendar),
                    title: Text(
                      "Histori Booking",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Divider(
                    height: 0.0,
                    color: Colors.grey,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DoctorsPage()
                        )
                      );
                    },
                    leading: Icon(CupertinoIcons.group),
                    title: Text(
                      "Dokter",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Divider(
                    height: 0.0,
                    color: Colors.grey,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PartnerAndCareerPage()
                        )
                      );
                    },
                    leading: Icon(CupertinoIcons.bag),
                    title: Text(
                        "Partner & Career",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AboutMePage()
                        )
                      );
                    },
                    leading: Icon(FontAwesomeIcons.info),
                    title: Text(
                      "Tentang Kami",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Divider(
                    height: 0.0,
                    color: Colors.grey,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => WebViewPage(
                            url: "https://docs.google.com/forms/d/e/1FAIpQLSc_-LVjNrvbrAM-DBUKSt54iq0GF9XLPhK6INsxk0quftYDpw/viewform",
                            title: "Feedback",
                          )
                        )
                      );
                    },
                    leading: Icon(Icons.favorite_border),
                    title: Text(
                      "Feedback",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Divider(
                    height: 0.0,
                    color: Colors.grey,
                  ),
                  ListTile(
                    onTap: () {
                      _showDialogLogout(context, mainProvider);
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
              GestureDetector(
                onDoubleTap: () {
                  // Navigator.of(context).pushNamed('/gamification');
                },
                child: Container(
                  height: 150.0,
                  child: Center(
                    child: Text(
                      "Halodoc v1.0.0@beta",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ]
          );
        }
      )
    );
  }

  Widget ui() { 
    return Consumer<AuthProvider>(
      builder: (context, data, _){
        return ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) =>
              _buildListItem(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ui()
    );
  }
}

class DialogLogout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, data, _) {
          return AlertDialog(
            content: new Text("Apakah anda yakin ingin logout?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "Batal",
                  style: TextStyle(color: Colors.black38),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  "Ya, Logout",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  Provider.of<AuthProvider>(context).logout();
                  Provider.of<AuthProvider>(context).checkLogin();
                },
              ),
            ],
          );
        },
      )
    );
  }
}