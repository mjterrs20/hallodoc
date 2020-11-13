import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/models/hospital.dart';
import 'package:hallodoc/providers/hospital/hospitalProvider.dart';
import 'package:provider/provider.dart';

class AboutMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HospitalProvider>(
      create: (_) => HospitalProvider(),
      child: AboutMeScreen()
    );
  }
}

class AboutMeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<AboutMeScreen> {

  TextStyle header = TextStyle(fontSize: ScreenUtil().setSp(35), fontWeight: FontWeight.w700, color: Colors.blue);
  TextStyle title = TextStyle(fontSize: ScreenUtil().setSp(25), fontWeight: FontWeight.bold,);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HospitalProvider>(context).fetchHospitals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Tentang Kami"),
        ),
        body: Consumer<HospitalProvider>(
          builder: (context, data, _) {
            if(data.getHospitals() == null) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                  strokeWidth: 2,
                ),
              );
            }
            Data dat = data.getHospitals().data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(.3), BlendMode.srcOver),
                        image: NetworkImage(
                          dat.about.imageUrl
                        ),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text("Sekilas Tentang SMKDev", style: header,),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(dat.about.desc),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/icons/ic_temui_kami.png",
                      height: 200,
                    ),
                  ),
                  Container(
                    child: Text("Temui Kami", style: header,),
                  ),
                  Column(
                    children: dat.hospitals
                      .map((i) {
                        return Builder(builder:
                          (BuildContext context) {
                        return Column(
                          children: [
                            Text(i.name, style: title),
                            Text(i.address)
                          ],
                        );
                      });
                    }).toList(),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/icons/ic_kontak_darurat.png",
                      height: 200,
                    ),
                  ),
                  Container(
                    child: Text("Layanan Darurat", style: header,),
                  ),
                  Column(
                    children: dat.layananDarurat
                      .map((i) {
                        return Builder(builder:
                          (BuildContext context) {
                        return Column(
                          children: [
                            Text(i.title, style: title),
                            Text(i.desc)
                          ],
                        );
                      });
                    }).toList(),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/icons/ic_layanan_time.png",
                      height: 200,
                    ),
                  ),
                  Container(
                    child: Text("waktu Operasional", style: header,),
                  ),
                  Column(
                    children: dat.hospitals
                      .map((i) {
                        return Builder(builder:
                          (BuildContext context) {
                          return Column(
                            children: [
                              Text(i.name, style: title),
                              Text(i.openHour.weekday),
                              Text(i.openHour.weekend),
                            ],
                          );
                      });
                    }).toList(),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}