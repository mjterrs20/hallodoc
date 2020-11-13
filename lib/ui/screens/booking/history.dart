import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/models/bookings.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/providers/booking/bookingProvider.dart';
import 'package:hallodoc/ui/widgets/views/circleImage.dart';
import 'package:provider/provider.dart';

class BookingHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookingProvider>(
          create: (_) => BookingProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        )
      ],
      child: BookingProviderScreen(),
    );
  }
}

class BookingProviderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<BookingProviderScreen> {


  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context).checkLogin();
      Provider.of<AuthProvider>(context).checkToken();
      Future.delayed(Duration(microseconds: 200), () {
        Provider.of<BookingProvider>(context).getBookingListData(
          token: Provider.of<AuthProvider>(context).getToken()
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Histori Booking"),
        ),
        body: Consumer<AuthProvider>(
          builder: (context, auth,_) {
            return Consumer<BookingProvider>(
              builder: (context, data,_) {
                if(data.isLoading()) {
                  return Center(
                        child:
                          CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                    strokeWidth: 2,
                  ));
                }
                if(data.getBookingList() != null && data.getBookingList().isEmpty) {
                  return Center(child: Text("Belum ada Histori"),);
                }
                
                return ListView.builder(
                  itemCount: data.getBookingList().length,
                  itemBuilder: (context, index) {
                    Bookings dat = data.getBookingList()[index];
                    DateTime dob = DateTime.parse(dat.date);
                    Duration dur =  dob.difference(DateTime.now());
                    int differencehour = dur.inHours;
                    int differenceDays = dur.inDays;
                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      width: ScreenUtil().screenWidth,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: CircleImage(
                              height: 60, width: 60,
                              url: dat.doctor.imageUrl
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dat.doctor.name,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(27),
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  dat.doctor.spesialist.name,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20),
                                    color: Colors.grey
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  dat.hospital.name,
                                  style: TextStyle(
                                    color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50, left: 10),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: dat.status == "active" ? Colors.orange : dat.status == "cancel" ? Colors.red :Colors.green,
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Text(
                                dat.status == "active" ? differencehour < 24 ? "$differencehour Jam Lagi" 
                                : "$differenceDays hari Lagi" : dat.status == "cancel" ? "Batal" :"Selesai",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        )
      ),
    );
  }
}