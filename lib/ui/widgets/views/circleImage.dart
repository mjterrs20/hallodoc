import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {

  final double height;
  final double width;
  final String url;

  CircleImage({@required this.height, @required this.url, @required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage(
            url
          )
        )
      )
    );
  }
}