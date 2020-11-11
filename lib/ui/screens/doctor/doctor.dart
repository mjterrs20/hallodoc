import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/models/doctor.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/providers/doctor/doctorProvider.dart';
import 'package:hallodoc/ui/screens/booking/createBooking.dart';
import 'package:hallodoc/ui/widgets/auth/login.dart';
import 'package:hallodoc/ui/widgets/auth/register.dart';
import 'package:provider/provider.dart';

class DoctorPage extends StatelessWidget {
  final String id;

  DoctorPage({this.id});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DoctorProvider>(
          create: (context) => DoctorProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: _DoctorPageFul(id: id),
    );
  }
}

class _DoctorPageFul extends StatefulWidget {
  final String id;

  _DoctorPageFul({this.id});

  @override
  State<StatefulWidget> createState() {
    return _DoctorState();
  }
}

class _DoctorState extends State<_DoctorPageFul> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoctorProvider>(context).fetchDoctor(id: widget.id);
      Provider.of<AuthProvider>(context).checkLogin();
    });
  }

  Widget divider(text) {
    return Container(
      padding: EdgeInsets.only(top: 25, bottom: 5),
      child: Text(
        text,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(40),
            color: Colors.blue,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  schedule(i) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    i.day,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(25),
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${i.startAt} - ${i.endAt}",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(25),
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text(
                i.hospital.name,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20), color: Colors.grey),
              ),
            )
          ]),
    );
  }

  void callback(value, doctor) {
    if(value == "logedin") {
      Navigator.pop(context);
      Future.delayed(Duration(milliseconds: 300), 
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CreateBookingPage(
              doctor: doctor
            ),
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: BottomAppBar(
              elevation: 18.0,
              child: Container(
                height: 65,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Consumer<DoctorProvider>(
                      builder: (context, data, _) {
                        return Consumer<AuthProvider>(
                          builder: (context, auth, _) {
                            return FlatButton(
                              textColor: Colors.white,
                              child: Text('Buat Janji'),
                              onPressed: () {
                                print(auth.isLogin());
                                if(!auth.isLogin()) {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                                    ),
                                    isScrollControlled: true,
                                    builder: (context) => Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: BottomSheetLogin(
                                            callback: callback,
                                            doctor: data.getDoctor(),
                                          ),
                                        )
                                      ),
                                    );
                                } 
                                if (auth.isLogin() && data.doctorExist()){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateBookingPage(
                                        doctor: data.getDoctor(),
                                      ),
                                    )
                                  );
                                } else {
                                  
                                }
                              },
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blue,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(8)),
                            );
                          }
                        );
                      },
                    )),
              ),
            ),
            body: Consumer<DoctorProvider>(builder: (context, data, _) {
              return Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 520,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: data.doctorExist() ? 
                            NetworkImage(data.getDoctor().imageUrl): AssetImage("assets/images/home_ilustration.png"), 
                            fit: BoxFit.cover
                          ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: ScreenUtil().screenWidth,
                          child: DraggableScrollableSheet(
                            builder: (BuildContext context,
                                ScrollController scrollController) {
                              return Container(
                                width: ScreenUtil().screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // color: Color(0xffF5F6FC),
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(15.0),
                                    topRight: const Radius.circular(15.0),
                                  ),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    SingleChildScrollView(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 30, 20, 0),
                                        controller: scrollController,
                                        child: Consumer<DoctorProvider>(
                                            builder: (context, data, _) {
                                          if (!data.doctorExist()) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                              strokeWidth: 2,
                                            ));
                                          }
                                          Data doctor = data.getDoctor();
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                doctor.name,
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(40),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Row(children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Image.asset(
                                                      'assets/icons/maki_doctor-11.png',
                                                      height: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    doctor.spesialist.name,
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(28),
                                                        color: Colors.grey),
                                                  ),
                                                ]),
                                              ),
                                              divider("Jadwal"),
                                              for (var i in doctor.schedules)
                                                schedule(i),
                                              divider("Biografi"),
                                              Container(
                                                child: Text(
                                                  doctor.bio,
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                              divider("Kredensial"),
                                              Container(
                                                child: Text(
                                                  doctor.credential,
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                              divider("Afiliansi Akademik"),
                                              Container(
                                                child: Text(
                                                  doctor.academicAffiliation,
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          );
                                        })),
                                  ],
                                ),
                              );
                            },
                            initialChildSize: .45,
                            minChildSize: .45,
                            maxChildSize: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            })));
  }
}

class BottomSheetLogin extends StatefulWidget {

  final Function callback;
  final Data doctor;

  BottomSheetLogin({@required this.callback, this.doctor});
  
  @override
  State<StatefulWidget> createState() {
    return _BottomSheeState();
  }
}
class _BottomSheeState extends State<BottomSheetLogin> {

  

  bool buildLogin = true;

  void changeUi(value) {
    buildLogin = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomCenter,
          child: Wrap(
            children: <Widget>[
              Consumer<AuthProvider>(
                builder:(context, data, _) {
                  if(data.isLogin()){
                    widget.callback('logedin', widget.doctor);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          width: 40.0,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Masuk',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      buildLogin ? 
                          LoginView() : 
                          RegisterView(),
                      Center(
                        child: RichText(
                            text: TextSpan(
                                text: buildLogin ?'Belum punya akun?' : "Sudah punya akun?",
                                style: TextStyle(color: Colors.black, fontSize: 18),
                                children: <TextSpan>[
                              TextSpan(
                                  text: buildLogin ? ' Daftar' : " Masuk",
                                  style:
                                      TextStyle(color: Colors.blueAccent, fontSize: 18),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print(buildLogin);
                                      buildLogin ? changeUi(false) : changeUi(true);
                                    })
                            ])),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
