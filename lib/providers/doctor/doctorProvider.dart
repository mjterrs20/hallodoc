import 'dart:convert';

import 'package:hallodoc/models/doctor.dart';
import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/doctor/doctorRepository.dart';

class DoctorProvider extends BaseProvider {
  
  Doctors doctors;
  Data doctor;

  Future<void> fetchDoctors() async {
    setLoading(true);
    await DoctorRepository().getDoctors().then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        setDoctors(Doctors.fromJson(json.decode(data.data)));
      } else {
        Map<String, dynamic> result = json.decode(data.data);
        setMessage(result.toString());
      }
    });
  }

  Future<void> fetchDoctor({String id}) async {
    setLoading(true);
    await DoctorRepository().getDoctor(id: id).then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        setDoctors(Doctors.fromJson(json.decode(data.data)));
      } else {
        Map<String, dynamic> result = json.decode(data.data);
        setMessage(result.toString());
      }
    });
  }


  void setDoctors(value) {
    doctors = value;
    notifyListeners();
  }

  void setDoctor(value) {
    doctor = value;
    notifyListeners();
  }

  Doctors getDoctors() { 
    return doctors;
  }

  Data getDoctor() {
    return doctor;
  }

  bool doctorsExist() {
    return doctors != null;
  }

  bool doctorExist() {
    return doctor != null;
  }

}