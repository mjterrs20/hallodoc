import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hallodoc/models/bookingDetailResponse.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/providers/booking/bookingProvider.dart';
import 'package:hallodoc/ui/widgets/views/circleImage.dart';
import 'package:hallodoc/utils/util.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingDetailPage extends StatelessWidget {

  final String id;
  BookingDetailPage({@required this.id});

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
      child: _BookingDetailScreen(id: id),
    );
  }
}

class _BookingDetailScreen extends StatefulWidget {

  final String id;
  _BookingDetailScreen({@required this.id});
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<_BookingDetailScreen> {

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // check login
      Provider.of<AuthProvider>(context).checkLogin();
      // cek apakah ada token
      Provider.of<AuthProvider>(context).checkToken();
      Future.delayed(Duration(microseconds: 200), () {
        // ambil token dan gunakan untuk mengambil data
        Provider.of<BookingProvider>(context).getBookingDetail(
          token: Provider.of<AuthProvider>(context).getToken(),
          id: widget.id
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:  BottomAppBar(
          elevation: 18.0,
          child: Container(
            height: 65,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 10),
              child: FlatButton(
                textColor: Colors.white,
                child: Text('Kembali'),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blue,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8)
                  ), 
                )
              ),
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<AuthProvider>(
              builder: (ctx, auth, _) {
              return Consumer<BookingProvider>(
                builder: (ctx, data, _) {
                  if(data.isLoading() || data.getBookingDetailData() == null) {
                    return Container(
                      height: ScreenUtil().screenHeight,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  BookingDetailResponse dataBooking = data.getBookingDetailData();
                  DateTime  bookingDate = DateTime.parse(dataBooking.data.date);

                  final Map<String, Marker> _markers =
                      {};
                  final marker = Marker(
                    markerId: MarkerId(dataBooking.data.hospital.name),
                    position: LatLng(
                        double.parse(dataBooking.data.hospital.lat),
                        double.parse(dataBooking.data.hospital.lng)),
                    infoWindow: InfoWindow(
                      title: dataBooking.data.hospital.name,
                      snippet: dataBooking.data.hospital.address,
                    ),
                  );
                  _markers[dataBooking.data.hospital.name] = marker;
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: ShapeDecoration(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(30),
                              ),
                            ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Icon(
                                dataBooking.data.status == "active" ? Icons.check_circle_outline_outlined :
                                dataBooking.data.status == "cancel" ? Icons.cancel : Icons.check_circle_outline_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text(
                              dataBooking.data.status == "active" ? "Booking Confirmed" :
                              dataBooking.data.status == "cancel" ? "Booking Canceled" : "Booking Completed",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(30)
                              ),
                            ),
                            Text("ID:${dataBooking.data.bookingCode}",
                              style: TextStyle(
                                  color: Colors.white
                                ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("CS akan menghubungi kamu nanti ya!",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Appointment Detail"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 20),
                        child: Container(
                          child: Row(
                            children: [
                              CircleImage(height: 50, url: dataBooking.data.doctor.imageUrl, width: 50),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataBooking.data.doctor.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(28)
                                      ),
                                    ),
                                    Text(dataBooking.data.doctor.spesialist.name),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 5),
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.blue,
                                )
                              ),
                              Expanded(
                                child: Text("Time & Date"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat("EEEE, d MMM yyyy", 'id_ID').format(bookingDate),
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(18)
                                      ),
                                    ),
                                    Text(
                                      DateFormat("hh:mm", 'id_ID').format(bookingDate),
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(28),
                                          fontWeight: FontWeight.bold
                                        ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18, left: 18),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Location"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18, right: 10, bottom: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  dataBooking.data.hospital.address,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(25)
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Util().launchURL(
                                    "https://www.google.com/maps/search/?api=1&query=${dataBooking.data.hospital.lat},${dataBooking.data.hospital.lng}");
                                },
                                child: Icon(Icons.directions_sharp, color: Colors.blue)
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 5,
                            top: 5,
                            right: 10),
                        child: Card(
                          child: Container(
                            height: 200,
                            child: GoogleMap(
                              onMapCreated:
                                  _onMapCreated,
                              scrollGesturesEnabled:
                                  false,
                              markers: _markers
                                  .values
                                  .toSet(),
                              initialCameraPosition:
                                  CameraPosition(
                                target: LatLng(
                                  double.parse(dataBooking.data.hospital.lat),
                                  double.parse(dataBooking.data.hospital.lng)
                                ),
                                zoom: 11.0,
                              ),
                            )
                          )
                        )
                      ),
                    ],
                  );
                },
              );
            }
          ),
        )
      ),
    );
  }
}