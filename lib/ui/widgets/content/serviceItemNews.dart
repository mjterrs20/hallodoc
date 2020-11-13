import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/models/content.dart';
import 'package:hallodoc/ui/screens/service/detailServicePage.dart';

class ServiceItemNews {
  Widget view(context,Data data) {
    return Container(
      width: 370,
      child: GestureDetector(
        onTap: () {
          if(data.type == "content") {  
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailServicePage(data: data), 
              )
            );
          }
        },
        child: Card(
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: ScreenUtil().screenWidth,
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/banner_placeholder.png',
                    image: data.imageUrl,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Text(
                  data.type  == "content" ? data.category : data.desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 12, top: 8, right: 10),
                child: Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 15, right: 10),
                child: RichText(
                  text: TextSpan(
                    text: data.type != "doctor" ? data.desc.length > 100 ? data.desc.substring(0, 80) : data.desc : "",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(23),
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: ' | Lihat Selengkapnya',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(23),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      )
                    ]
                  )
                )
              )
            ],
          ),
        ),
      )
    );
  }
}