import 'package:flutter/material.dart';
import 'package:hallodoc/models/content.dart';
import 'package:hallodoc/ui/widgets/content/serviceItem.dart';
import 'package:hallodoc/ui/widgets/content/serviceItemNews.dart';

class ServiceList extends StatefulWidget {

  final Content content;
  final bool canScroll;
  final Axis scrollDirection;

  ServiceList({@required this.content, @required this.canScroll, @required this.scrollDirection});

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
      itemCount: widget.content.data.length,
      itemBuilder: (context, index) {
        Data data = widget.content.data[index];
        return widget.scrollDirection == Axis.horizontal 
                  ? ServiceItem(data: data) 
                  : ServiceItemNews(data: data);
      }, 
    );
  }
}