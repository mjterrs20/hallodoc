import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/models/content.dart';
import 'package:hallodoc/ui/screens/service/detailServicePage.dart';

class BannerSlider extends StatefulWidget {

  final List<Data> items;

  BannerSlider({@required this.items});

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _current = 1;


  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 1.0,
            onPageChanged: (int index, _) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DetailServicePage(data: i), 
                      )
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      width: ScreenUtil().screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                              i.imageUrl,
                            ),
                            fit: BoxFit.fill
                          )
                        ),
                    ),
                  )
                );
                // return Container(
                //   width: ScreenUtil().screenWidth,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10.0),
                //     child: FadeInImage.assetNetwork(
                //       fit: BoxFit.cover,
                //       placeholder: 'assets/images/banner_placeholder.png',
                //       image: i,
                //     ),
                //   ),
                // );
              },
            );
          }).toList(),
        ),
        Positioned(
            bottom: 0.0,
            left: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.items.length, (index) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 3.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Colors.blueGrey
                              : Colors.white),
                    );
                  },
                );
              }).toList(),
            )
          )
      ],
    );
  }
}
