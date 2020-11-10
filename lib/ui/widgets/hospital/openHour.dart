import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenHourView extends StatelessWidget {

  final String title;
  final String address;
  final String weekday;
  final String weekend;

  OpenHourView({this.title, this.address, this.weekday, this.weekend});

  final TextStyle descStyle = TextStyle(fontSize: ScreenUtil().setSp(27));
  final TextStyle titleStyle = TextStyle(
                                  fontSize: ScreenUtil().setSp(30),
                                  fontWeight: FontWeight.bold);

  Widget item({Widget child}) {
    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: child,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item(
            child: Text(
              title,
              style: titleStyle
            ),
          ),
          
          address.isNotEmpty ? 
          item(
            child: Text(address,
              style: descStyle
            )
          ): Container(),
          item(
            child:Text(weekday,
              style: descStyle
            )
          ),
          item(
            child: Text(weekend,
              style: descStyle
            )
          ),
        ],
      )
    );
  }
}
