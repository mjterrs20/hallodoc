import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hallodoc/models/content.dart';
import 'package:hallodoc/models/hospital.dart';
import 'package:hallodoc/providers/auth/authProvider.dart';
import 'package:hallodoc/providers/content/contentProvider.dart';
import 'package:hallodoc/providers/doctor/doctorProvider.dart';
import 'package:hallodoc/providers/hospital/hospitalProvider.dart';
import 'package:hallodoc/ui/screens/chatbot/chatbot.dart';
import 'package:hallodoc/ui/widgets/content/serviceItemNews.dart';
import 'package:hallodoc/ui/widgets/content/serviceList.dart';
import 'package:hallodoc/ui/widgets/doctor/doctorList.dart';
import 'package:hallodoc/ui/widgets/hospital/openHour.dart';
import 'package:hallodoc/ui/widgets/views/bannerSlider.dart';
import 'package:draggable_floating_button/draggable_floating_button.dart';
import 'package:hallodoc/ui/widgets/views/divider.dart';
import 'package:hallodoc/utils/util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContentProvider>(
            create: (_) => ContentProvider()),
        ChangeNotifierProvider<DoctorProvider>(create: (_) => DoctorProvider()),
        ChangeNotifierProvider<HospitalProvider>(
            create: (_) => HospitalProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: HomePageStateful(),
    );
  }
}

class HomePageStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePageStateful> {
  int selectedIndex = 0;
  double panelPosition = 0.0;
  bool scroller = false;

  TextEditingController _controller = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  bool isSearching = false;

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DoctorProvider>(context).fetchDoctors();
      Provider.of<ContentProvider>(context).fetchContent(query: null);
      Provider.of<HospitalProvider>(context).fetchHospitals();
    });
  }

  Widget futureDoctorView(data) {
    return Container(
        padding: EdgeInsets.only(top: 10, right: 10),
        child: DoctorList(
          canScroll: true,
          scrollDirection: Axis.horizontal,
          doctors: data,
        ));
  }

  Widget futureNewsView(data) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: data.data != null ? data.data.length : 0,
      itemBuilder: (context, index) {
        Data dat = data.data[index];
        return ServiceItemNews().view(context, dat);
      },
    );
  }

  Widget searchField() {
    return Container(
      height: 35,
      margin: EdgeInsets.only(left: 15, right: 20, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // color: Color(0xffF5F6FC),
          color: Colors.white),
      child: TextFormField(
        focusNode: textFieldFocus,
        controller: _controller,
        onEditingComplete: () {
          if (_controller.text.isNotEmpty) {
            isSearching = true;
          } else {
            isSearching = false;
          }
          Provider.of<ContentProvider>(context, listen: false)
              .fetchContent(query: "/search?query=${_controller.text}");
          textFieldFocus.unfocus();
          setState(() {});
        },
        textInputAction: TextInputAction.done,
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search',
          // isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 1.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.1),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 520,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/home_ilustration.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Siap Tolong",
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {},
                      icon: Icon(Icons.favorite),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: ScreenUtil().screenWidth,
                  child: DraggableScrollableSheet(
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        width: ScreenUtil().screenWidth,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          color: Color(0xffF5F6FC),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(15.0),
                            topRight: const Radius.circular(15.0),
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            isSearching
                                ? SingleChildScrollView(
                                    padding: EdgeInsets.only(top: 70),
                                    controller: scrollController,
                                    child: Consumer<ContentProvider>(
                                      builder: (context, data, child) {
                                        if (data.isLoading()) {
                                          return Container(
                                              height:
                                                  ScreenUtil().screenHeight *
                                                      .5,
                                              margin: EdgeInsets.only(top: 100),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                                strokeWidth: 2,
                                              )));
                                        }

                                        if (!data.isExist()) {
                                          return Container(
                                              height:
                                                  ScreenUtil().screenHeight *
                                                      .5,
                                              margin: EdgeInsets.only(top: 100),
                                              child: Center(
                                                child: Text(
                                                    "Tidak ada data yang cocok"),
                                              ));
                                        }
                                        return Container(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: ServiceList(
                                              canScroll: false,
                                              scrollDirection: Axis.vertical,
                                              content: data.getContent(),
                                              item: ServiceItemNews().view,
                                            ));
                                      },
                                    ),
                                  )
                                : SingleChildScrollView(
                                    padding: EdgeInsets.fromLTRB(15, 70, 10, 0),
                                    controller: scrollController,
                                    child: Column(
                                      children: <Widget>[
                                        Consumer<ContentProvider>(
                                          builder: (context, data, child) {
                                            if (!data.isExist()) {
                                              return Container();
                                            }
                                            Content contentPromo = Content(
                                                data: data.getPromoAndEvent(
                                                    data.getContent().data));
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 10, top: 5),
                                              child: BannerSlider(
                                                items: contentPromo.data,
                                              ),
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 10, top: 20),
                                          child: CustomDivider(
                                            onTap: () {
                                              print("asasa");
                                            },
                                            title: "Temui Kami",
                                          ),
                                        ),
                                        Consumer<HospitalProvider>(
                                          builder: (context, data, _) {
                                            if (!data.hospitalsExist()) {
                                              return Container();
                                            }
                                            final Map<String, Marker> _markers =
                                                {};
                                            for (final data
                                                in data.hospitals.data) {
                                              final marker = Marker(
                                                markerId: MarkerId(data.name),
                                                position: LatLng(
                                                    double.parse(data.lat),
                                                    double.parse(data.lng)),
                                                infoWindow: InfoWindow(
                                                  title: data.name,
                                                  snippet: data.address,
                                                ),
                                              );
                                              _markers[data.name] = marker;
                                            }
                                            return Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    top: 10,
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
                                                              double.parse(data
                                                                  .getHospitals()
                                                                  .data[0]
                                                                  .lat),
                                                              double.parse(data
                                                                  .getHospitals()
                                                                  .data[0]
                                                                  .lng),
                                                            ),
                                                            zoom: 11.0,
                                                          ),
                                                        ))));
                                          },
                                        ),
                                        Consumer<HospitalProvider>(
                                          builder: (context, data, _) {
                                            if (!data.hospitalsExist()) {
                                              return Container();
                                            }
                                            return Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: data
                                                      .getHospitals()
                                                      .data
                                                      .map((i) {
                                                    return Builder(builder:
                                                        (BuildContext context) {
                                                      return GestureDetector(
                                                          onTap: () {
                                                            mapController.animateCamera(
                                                                CameraUpdate.newCameraPosition(
                                                                    CameraPosition(
                                                                        target:
                                                                            LatLng(
                                                                          double.parse(
                                                                              i.lat),
                                                                          double.parse(
                                                                              i.lng),
                                                                        ),
                                                                        zoom:
                                                                            15.0)));
                                                            // setState(() {});
                                                          },
                                                          child: Container(
                                                            width: ScreenUtil()
                                                                .screenWidth,
                                                            color: Colors
                                                                .transparent,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8),
                                                            child: OpenHourView(
                                                              title: i.name,
                                                              address:
                                                                  i.address,
                                                              weekday: i.email,
                                                              weekend: i.phone,
                                                            ),
                                                          ));
                                                    });
                                                  }).toList(),
                                                ));
                                          },
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 15),
                                            child: OpenHourView(
                                              title: "BPJS",
                                              address: "",
                                              weekday: "assa",
                                              weekend: "asas",
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 10, top: 20),
                                          child: CustomDivider(
                                            onTap: () {
                                              print("asasa");
                                            },
                                            title: "Tentang Kami",
                                          ),
                                        ),
                                        Consumer<DoctorProvider>(
                                          builder: (context, data, child) {
                                            if (!data.doctorsExist()) {
                                              return Container();
                                            }
                                            return Container(
                                                height: 320,
                                                child: futureDoctorView(
                                                    data.getDoctors()));
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 10, top: 20),
                                          child: CustomDivider(
                                            onTap: () {
                                              print("asasa");
                                            },
                                            title: "Berita Terbaru",
                                          ),
                                        ),
                                        Consumer<ContentProvider>(
                                          builder: (context, data, child) {
                                            if (!data.isExist()) {
                                              return Container();
                                            }
                                            return Container(
                                                height: 310,
                                                child: futureNewsView(
                                                    data.getContent()));
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5,
                                              right: 10,
                                              top: 20,
                                              bottom: 5),
                                          child: CustomDivider(
                                            onTap: () {
                                              print("asasa");
                                            },
                                            title: "Kontak Pengaduan",
                                          ),
                                        ),
                                        Consumer<HospitalProvider>(
                                          builder: (context, data, child) {
                                            if (!data.hospitalsExist()) {
                                              return Container();
                                            }
                                            Hospital hospital =
                                                data.getHospitals().data[0];
                                            return Container(
                                                height: 230,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      onTap: () {
                                                        Util().launchURL(
                                                            "https://www.google.com/maps/search/?api=1&query=${hospital.lat},${hospital.lng}");
                                                      },
                                                      leading: Icon(
                                                          CupertinoIcons
                                                              .location),
                                                      title: Text(
                                                        data
                                                            .getHospitals()
                                                            .data[0]
                                                            .name,
                                                        style: TextStyle(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(30),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          hospital.address),
                                                    ),
                                                    ListTile(
                                                      onTap: () {
                                                        Util().launchURL(
                                                            "mailto:${hospital.email}");
                                                      },
                                                      leading: Icon(
                                                          CupertinoIcons
                                                              .envelope),
                                                      title: Text(
                                                          hospital.email,
                                                          style: ThemeData()
                                                              .textTheme
                                                              .bodyText2),
                                                    ),
                                                    ListTile(
                                                      onTap: () {
                                                        Util().launchURL(
                                                            "tel:${hospital.phone}");
                                                      },
                                                      leading: Icon(
                                                          CupertinoIcons.phone),
                                                      title: Text(
                                                          hospital.phone,
                                                          style: ThemeData()
                                                              .textTheme
                                                              .bodyText2),
                                                    ),
                                                  ],
                                                ));
                                          },
                                        ),
                                      ],
                                    )),
                            Positioned(
                              top: 0,
                              child: Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xffF5F6FC),
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(15.0),
                                    topRight: const Radius.circular(15.0),
                                  ),
                                  boxShadow: !scroller
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 6,
                                            offset: new Offset(0.0, 3.0),
                                          )
                                        ],
                                ),
                                child: Center(
                                  child: Container(
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
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30, bottom: 50),
                              color: Color(0xffF5F6FC),
                              child: searchField(),
                            ),
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
          // Floating Draggable
          DraggableFloatingActionButton(
            // data: 'dfab_demo',
            offset: new Offset(350, MediaQuery.of(context).size.height * 0.5),
            backgroundColor: Colors.red,
            child: new Icon(
              Icons.question_answer,
              color: Colors.yellow,
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatbotPage(),
                )),
            appContext: context,
          )
        ],
      ),
    ));
  }
}
