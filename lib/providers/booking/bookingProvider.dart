import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hallodoc/models/bookingDetailResponse.dart';
import 'package:hallodoc/models/bookings.dart';
import 'package:hallodoc/models/doctor.dart' as Doctor;
import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/booking/bookingRepository.dart';
import 'package:intl/intl.dart';

class BookingProvider extends BaseProvider {

  bool _created = false;
  Doctor.Hospital _hospital;

  DateFormat formatDay = new DateFormat('EEEE', 'id_ID');

  BookingList _listBooking;
  BookingDetailResponse _bookingDetail;

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


  Future<void> getBookingDetail({token, id}) async {
    setLoading(true);
    await BookingRepository().getBooking(id, token).then((response) {
      setLoading(false);
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        print(data);
        setBookingDetail(BookingDetailResponse.fromJson(data));
      } else {
        Map<String, dynamic> result = json.decode(response.data);
        setError(true);
        setMessage(result['message'].toString());
      }
    });
  }

  setBookingDetail(value) {
    _bookingDetail = value;
    notifyListeners();
  }

  BookingDetailResponse getBookingDetailData() {
    return _bookingDetail != null ? _bookingDetail : null;
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
    DateTime choosed = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, time.hour, time.minute);
    if(choosed.day == DateTime.now().day && (choosed.hour - DateTime.now().hour) < 1) {
      print("booking harus lebih dari jam saat ini");
      return false;
    }
    var timeSchedule =  doctor.schedules.where((Doctor.Schedules schedule) {
      TimeOfDay startTime = TimeOfDay(hour: int.parse(schedule.startAt.split(":")[0]), minute: int.parse(schedule.startAt.split(":")[1]));
      TimeOfDay endTime = TimeOfDay(hour: int.parse(schedule.endAt.split(":")[0]), minute: int.parse(schedule.endAt.split(":")[1]));

      DateTime startAt = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, startTime.hour, startTime.minute);
      DateTime endAt = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, endTime.hour, endTime.minute);
      print(choosed.isAfter(startAt) && choosed.isBefore(endAt));
      return choosed.isAfter(startAt) && choosed.isBefore(endAt);
    });
    
    return timeSchedule.length > 0;
  }

  checkScheduleDay(pickedDate, Doctor.Data doctor) {
    Duration dur =  pickedDate.difference(DateTime.now());
    if(dur.inDays > 14) {
      print("booking tidak boleh lebih dari 14 hari dari sekarang");
      return false;
    }
    String day = formatDay.format(pickedDate);
    var daySchedule =  doctor.schedules.where((Doctor.Schedules schedule) => schedule.day.contains(day));
    if(daySchedule.isNotEmpty) {
      setSelectedHospital(daySchedule.first.hospital);
    }
    return daySchedule.length > 0;
  }

  void setSelectedHospital(value) {
    _hospital = value;
    notifyListeners();
  }

  Doctor.Hospital getSelectedHospital() {
    return _hospital;
  }
}