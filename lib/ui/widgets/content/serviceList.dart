import 'package:flutter/material.dart';
import 'package:hallodoc/models/content.dart';

class ServiceList extends StatefulWidget {

  final Content content;
  final bool canScroll;
  final Axis scrollDirection;
  final Function item;

  ServiceList({
    @required this.content,
    @required this.canScroll,
    @required this.scrollDirection,
    @required this.item
  });

  @override
  State<StatefulWidget> createState() {
    return _ServiceState();
  }
}


class _ServiceState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: widget.canScroll ? ScrollPhysics() : NeverScrollableScrollPhysics(),
      scrollDirection: widget.scrollDirection,
      itemCount: widget.content.data != null ? widget.content.data.length : 0,
      itemBuilder: (context, index) {
        Data data = widget.content.data[index];
        return widget.item(context, data);
      }, 
    );
  }
}