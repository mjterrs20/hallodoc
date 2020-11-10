import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/models/doctor.dart';
import 'package:hallodoc/providers/doctor/doctorProvider.dart';
import 'package:hallodoc/ui/screens/booking/createBooking.dart';
import 'package:provider/provider.dart';

class DoctorPage extends StatelessWidget {
  final String id;

  DoctorPage({this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DoctorProvider(),
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
                        return FlatButton(
                          textColor: Colors.white,
                          child: Text('Buat Janji'),
                          onPressed: () {
                            if (data.doctorExist()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateBookingPage(
                                      doctor: data.getDoctor(),
                                    ),
                                  ));
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
