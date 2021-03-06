import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:hallodoc/models/doctor.dart';
import 'package:hallodoc/providers/doctor/doctorProvider.dart';
import 'package:hallodoc/ui/screens/doctor/doctor.dart';
import 'package:hallodoc/ui/widgets/views/circleImage.dart';
import 'package:provider/provider.dart';

class DoctorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> DoctorProvider(),
      child: _DoctorsPageFul(),
    );
  }
}

class _DoctorsPageFul extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DoctorsState();
  }
}

class _DoctorsState extends State<_DoctorsPageFul> {


  @override
  void initState() { 
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoctorProvider>(context).fetchDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Booking")
      ),
      body: RefreshIndicator(
        onRefresh: _getData,
        child:Provider.of<DoctorProvider>(context).isLoading() ?
          SingleChildScrollView(
            child: Container(
              height: ScreenUtil().screenHeight,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white, strokeWidth: 2,
                )
              )
            ),
          ):
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 10, bottom: 20),
              child: Text("Buat Janji & Konsultasi Dokter",
                maxLines: 2,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: 
              Consumer<DoctorProvider>(
                builder: (context, data, _) {
                  if(!data.doctorsExist()) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                        strokeWidth: 2,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.getDoctors().data.length,
                    itemBuilder: (context, index) {
                      Data doctor = data.getDoctors().data[index];
                      return Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => DoctorPage(id: doctor.id.toString()), 
                              )
                            );
                          },
                          child: Ink(
                            width: ScreenUtil().scaleWidth,
                            child: ListTile(
                              contentPadding: EdgeInsets.only(left: 15, top: 10),
                              leading: CircleImage(
                                height: 60, width: 60,
                                url: doctor.imageUrl
                              ),
                              title: Text(doctor.name),
                              subtitle: Text(doctor.spesialist.name),
                            )
                          )
                        )
                      );
                    }, 
                  );
                }
              ),
            )
          ],
        ),
      )
    );
  }
}