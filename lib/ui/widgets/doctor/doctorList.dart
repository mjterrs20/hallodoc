import 'package:flutter/material.dart';
import 'package:hallodoc/models/doctor.dart';
import 'package:hallodoc/ui/widgets/doctor/doctorCardItem.dart';
import 'package:hallodoc/ui/widgets/doctor/doctorListItem.dart';

class DoctorList extends StatefulWidget {

  final Doctors doctors;
  final bool canScroll;
  final Axis scrollDirection;

  DoctorList({@required this.doctors, @required this.canScroll, @required this.scrollDirection});

  @override
  State<StatefulWidget> createState() {
    return _DoctorState();
  }
}


class _DoctorState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: widget.canScroll ? ScrollPhysics() : NeverScrollableScrollPhysics(),
      scrollDirection: widget.scrollDirection,
      itemCount: widget.doctors.data != null ? widget.doctors.data.length : 0,
      itemBuilder: (context, index) {
        Data data = widget.doctors.data[index];
        return widget.scrollDirection == Axis.horizontal 
                  ? DoctorCardItem(data: data) 
                  : DoctorListItem();
      }, 
    );
  }
}