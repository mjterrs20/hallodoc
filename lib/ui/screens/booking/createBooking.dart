import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:hallodoc/models/doctor.dart';
import 'package:hallodoc/providers/booking/bookingProvider.dart';
import 'package:hallodoc/ui/widgets/views/circleImage.dart';
import 'package:provider/provider.dart';

class CreateBookingPage extends StatelessWidget {
  final Data doctor;

  CreateBookingPage({@required this.doctor});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingProvider(),
      child: _BookingPageFul(doctor: doctor),
    );
  }
}

class _BookingPageFul extends StatefulWidget {
  final Data doctor;

  _BookingPageFul({@required this.doctor});
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<_BookingPageFul> {

  FocusNode _textFieldFocus = FocusNode();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Booking Confirm"),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 18.0,
          child: Container(
            height: 65,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 10),
              child: FlatButton(
                textColor: Colors.white,
                child: Text('Konfirmasi'),
                onPressed: () {
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
          child: GestureDetector(
            onTap: () => _textFieldFocus.unfocus(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: CircleImage(
                            height: 80, width: 80, url: widget.doctor.imageUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.doctor.name,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(widget.doctor.spesialist.name)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    width: ScreenUtil().screenWidth,
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Booking Detail",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(35),
                            fontWeight: FontWeight.bold,
                            color: Colors.blue
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                            child: Text(
                              "Booking untuk",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(28),
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){},
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Ganti Pasien",
                                style: TextStyle(
                                  color: Colors.blue
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text("Nama: Udin"),
                      Text("Jenis Kelamin: Laki-laki"),
                      Text("Status: Saya sendiri"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: ScreenUtil().screenHeight * .465,
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                              child: Text(
                                "Booking tanggal",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(28),
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Jumat, 23 Okt 2020",
                                    children: [
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Icon(Icons.calendar_today, color: Colors.blue,),
                                        )
                                      )
                                    ],
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: ScreenUtil().setSp(28)
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("Pesan"),
                        ),
                        Container(
                          child: TextField(
                            minLines: 5,
                            maxLines: 10,
                            controller: _controller,
                            focusNode: _textFieldFocus,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Write your message here',
                              filled: true,
                              fillColor: Colors.white10,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
