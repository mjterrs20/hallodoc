import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:hallodoc/models/doctor.dart';
import 'package:hallodoc/models/infoPatient.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/providers/booking/bookingProvider.dart';
import 'package:hallodoc/providers/booking/infoPatientProvider.dart';
import 'package:hallodoc/ui/screens/booking/infoPatientList.dart';
import 'package:hallodoc/ui/widgets/booking/success.dart';
import 'package:hallodoc/ui/widgets/views/circleImage.dart';
import 'package:hallodoc/widget/miscellaneous.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateBookingPage extends StatelessWidget {
  final Data doctor;

  CreateBookingPage({@required this.doctor});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InfoPatientProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        )
      ],
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

  InfoPatient selected;

  DateTime pickedDate;
  TimeOfDay time;

  @override
  void initState() { 
    super.initState();
    getLocalData();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context).checkUserId();
      Provider.of<AuthProvider>(context).checkToken();
    });
  }

  getLocalData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InfoPatientProvider>(context).checkSelected();
      Future.delayed(Duration(microseconds: 100) ,() {
        Provider.of<InfoPatientProvider>(context).getInfoPatient(
          Provider.of<InfoPatientProvider>(context).getSelected() ?? 1
        );
      });
    });
  }

  _pickDate(Data doctor) async {
   DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-1),
      lastDate: DateTime(DateTime.now().year+1),
      initialDate: pickedDate,
    );    
    if(date != null) {
      if(date.day >= DateTime.now().day) {
        setState(() {
          pickedDate = date;
        });
        Duration dur =  pickedDate.difference(DateTime.now());
        if(dur.inDays > 14) {
          showDialog("Booking hanya boleh dilakukan 14 hari dari sekarang");
        }

        else if(Provider.of<BookingProvider>(context).checkScheduleDay(pickedDate, doctor)) {
          _pickTime(doctor);
        } else {
          showDialog("Dokter tidak ada pada hari yang dipilih");
        }
      } else {
        showDialog("Silahkan pilih tanggal yang benar");
      }
    }
  }

  _pickTime(doctor) async {
   TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: time
    );    
    if(t != null) {
      setState(() {
        time = t;
      });
      if(!Provider.of<BookingProvider>(context).checkScheduleTime(pickedDate, time, doctor)) {
        showDialog("Dokter tidak ada pada waktu yang dipilih");
      }
    }
  }

  showDialog(content) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Booking Confirm"),
        ),
        bottomNavigationBar: Consumer<BookingProvider>(
          builder: (context, data, _) {
            return BottomAppBar(
              elevation: 18.0,
              child: Container(
                height: 65,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 30, right: 30, top: 10, bottom: 10),
                  child: FlatButton(
                    textColor: Colors.white,
                    child: data.isLoading()
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 2,
                        )
                      : Text('Konfirmasi'),
                    onPressed: () {
                      print(selected);
                      print(_controller.text.isNotEmpty);
                      if(
                        Provider.of<BookingProvider>(context).checkScheduleDay(pickedDate, widget.doctor)
                        && Provider.of<BookingProvider>(context).checkScheduleTime(pickedDate, time, widget.doctor)
                        && selected != null
                      ) {
                        HallodocWidget.hallodocDialog(
                          context: context,
                          title: "Maaf",
                          content: "Apakah data sudah benar?",
                          buttons: <Widget>[
                              HallodocWidget.hallodocDialogButton(
                                buttonText: 'Belum',
                                onPressed: () {
                                  Navigator.pop(context);
                                }
                              ),
                              new FlatButton(
                                child: new Text(
                                "Ya",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () async {
                                  print(selected);
                                  print(_controller.text.isNotEmpty);
                                  if(
                                      Provider.of<BookingProvider>(context).checkScheduleDay(pickedDate, widget.doctor)
                                      && Provider.of<BookingProvider>(context).checkScheduleTime(pickedDate, time, widget.doctor)
                                      && selected != null && _controller.text.isNotEmpty
                                    ) {
                                      Provider.of<BookingProvider>(context).saveBooking(
                                        data: {
                                          'doctor_id': widget.doctor.id,
                                          'hospital_id': Provider.of<BookingProvider>(context).getSelectedHospital().id,
                                          'patient_id': Provider.of<AuthProvider>(context).getUserId(),
                                          'booking_for': selected.status,
                                          'message': _controller.text,
                                          'info_patient_name': selected.name,
                                          'info_patient_status': selected.status,
                                          'info_patient_sex': selected.sex,
                                          'date': "${pickedDate.year}-${pickedDate.month}-${pickedDate.day} ${time.hour}:${time.minute}",
                                        },
                                        token: Provider.of<AuthProvider>(context).getToken(),
                                      ).then((value) {
                                        if(data.isCreated()) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SuccessBookingScreen(
                                                boookingCode: data.getMessage()
                                              ),
                                            )
                                          );
                                        } else if(data.hasError()) {
                                          showDialog(data.getMessage());
                                        }
                                      });
                                  }
                                  Navigator.pop(context);
                                },
                            ),
                          ]);
                      }  else {
                        showDialog("Harap lengkapi isian anda");
                      }
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
            );
          },
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
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
                                  child: BottomSheetSchedule(
                                    doctor: widget.doctor,
                                  ),
                                )
                              ),
                            );
                          },
                          child: Icon(Icons.info_outline)
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
                            onTap: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InfoPatientPage()
                                )
                              );
                              print(result);
                              if(result != null) {
                                getLocalData();
                              }
                            },
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
                      Consumer<InfoPatientProvider>(
                        builder: (context, data, _) {
                          if(data.getSelected() != null && data.getInfoPatients() != null) {
                            selected = data.getInfoPatients()[0];
                          }
                          if(data.getSelected() == null || data.getInfoPatients() != null &&  data.getInfoPatients().isEmpty) {
                            return Text("Harap pilih pasien");
                          }
                          if(selected == null) {
                            return CircularProgressIndicator(
                              backgroundColor: Colors.blue,
                              strokeWidth: 2,
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama: ${selected.name}"),
                              Text("Jenis Kelamin: ${selected.sex == 1 ?'Laki-laki' : 'Perempuan'}"),
                              Text("Status: ${selected.status}"),
                            ],
                          );
                        }
                      ),
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
                              onTap: (){
                                _pickDate(widget.doctor);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: DateFormat("EEEE, d MMM yyyy", 'id_ID').format(pickedDate ?? DateTime.now()),
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

class BottomSheetSchedule extends StatefulWidget {
  final Data doctor;

  BottomSheetSchedule({this.doctor});
  
  @override
  State<StatefulWidget> createState() {
    return _BottomSheeState();
  }
}
class _BottomSheeState extends State<BottomSheetSchedule> {

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
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomCenter,
          child: Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Jadwal',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  for (var i in widget.doctor.schedules)
                    schedule(i),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
