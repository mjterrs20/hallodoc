import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/models/content.dart';

import 'package:intl/intl.dart';  //for date format


class DetailServicePage extends StatefulWidget {

  final Data data;

  DetailServicePage({@required this.data});

  @override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<DetailServicePage> {
  var formatter = new DateFormat('dd MMMM yyyy', 'id_ID');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.data.category),
        elevation: 0.0,
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 200,
              child: FadeInImage.assetNetwork(
                fit: BoxFit.fill,
                placeholder: 'assets/images/banner_placeholder.png',
                image: widget.data.imageUrl,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      widget.data.category ?? widget.data.name,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(25),
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      widget.data.title,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(45),
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      formatter.format(DateTime.parse(widget.data.date)),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(25),
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 30),
                    child: Text(
                      widget.data.desc,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                        color: Colors.black
                      ),
                    )
                  ),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}

