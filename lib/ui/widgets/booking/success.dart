import 'package:flutter/material.dart';
import 'package:hallodoc/ui/screens/home/homePage.dart';

class SuccessBookingScreen extends StatelessWidget {

  final String boookingCode;
  SuccessBookingScreen({this.boookingCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.check_circle_rounded,
              size: 150,
              color: Colors.white,
            )
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Booking Sukses",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Kode booking anda",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              boookingCode,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Costumer Service kami akan menghubungi anda untuk konfirmasi selanjutnya",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            )
          ),
          SizedBox(
            height: 230,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child:  Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                child: Padding(
              padding: EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 10),
              child: FlatButton(
                textColor: Colors.blue,
                child: Text('Lihat Histori'),
                onPressed: () {
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                    ),
                  );
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blue,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8)
                  ), 
                )
              ),
            )
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Kembali ke Home",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              )
            ),
          ),
        ]
      ),
    );
  }
}