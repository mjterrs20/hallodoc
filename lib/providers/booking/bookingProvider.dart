import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hallodoc/models/bookings.dart';
import 'package:hallodoc/models/doctor.dart';
import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/booking/bookingRepository.dart';
import 'package:intl/intl.dart';

class BookingProvider extends BaseProvider {

  bool _created = false;
  Hospital _hospital;

  DateFormat formatDay = new DateFormat('EEEE', 'id_ID');

  BookingList _listBooking;

  Future<void> getBookingListData({token}) async {
    setLoading(true);
    await BookingRepository().getAllBooking(token).then((response) {
      setLoading(false);
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        setBookingList(BookingList.fromJson(data));
      } else {
        Map<String, dynamic> result = json.decode(response.data);
        setError(true);
        setMessage(result['message'].toString());
      }
    });
  }

  setBookingList(value) {
    _listBooking = value;
    notifyListeners();
  }

  List<Bookings> getBookingList() {
    return _listBooking != null ?_listBooking.data : [];
  }

  Future<void> saveBooking({Map<String, dynamic> data, token}) async {
    setLoading(true);
    await BookingRepository().saveBooking(data, token).then((response) {
      setLoading(false);
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        setCreated(true);
        setMessage(data['data']['booking_code']);
      } else {
        Map<String, dynamic> result = json.decode(response.data);
        setError(true);
        setMessage(result['message'].toString());
      }
    });
  }

  void setCreated(value) {
    _created = value;
    notifyListeners();
  }

  bool isCreated() {
    return _created;
  }

  checkScheduleTime(pickedDate, time, doctor) {
    var timeSchedule =  doctor.schedules.where((Schedules schedule) {
      TimeOfDay startTime = TimeOfDay(hour: int.parse(schedule.startAt.split(":")[0]), minute: int.parse(schedule.startAt.split(":")[1]));
      TimeOfDay endTime = TimeOfDay(hour: int.parse(schedule.endAt.split(":")[0]), minute: int.parse(schedule.endAt.split(":")[1]));

      DateTime choosed = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, time.hour, time.minute);
      DateTime startAt = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, startTime.hour, startTime.minute);
      DateTime endAt = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, endTime.hour, endTime.minute);
      return choosed.isAfter(startAt) && choosed.isBefore(endAt);
    });
    return timeSchedule.length > 0;
  }

  checkScheduleDay(pickedDate, Data doctor) {
    String day = formatDay.format(pickedDate);
    var daySchedule =  doctor.schedules.where((Schedules schedule) => schedule.day.contains(day));
    if(daySchedule.isNotEmpty) {
      setSelectedHospital(daySchedule.first.hospital);
    }
    return daySchedule.length > 0;
  }

  void setSelectedHospital(value) {
    _hospital = value;
    notifyListeners();
  }

  Hospital getSelectedHospital() {
    return _hospital;
  }
}