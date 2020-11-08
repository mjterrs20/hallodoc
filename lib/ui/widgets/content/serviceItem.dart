import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:hallodoc/models/content.dart';
import 'package:hallodoc/ui/screens/service/detailServicePage.dart';

class ServiceItem {
  Widget itemSmall(context, Data data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => DetailServicePage(data: data), 
          )
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 2.0,
        shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(
                  data.imageUrl,
                ),
                fit: BoxFit.fill
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 28, right: 10),
                child: Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(40),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}