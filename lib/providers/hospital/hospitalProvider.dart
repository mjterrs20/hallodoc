import 'dart:convert';

import 'package:hallodoc/models/hospital.dart';
import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/hospital/hospitalRepository.dart';

class HospitalProvider extends BaseProvider {
  
  Hospitals hospitals;
  Hospital hospital;

  Future<void> fetchHospitals() async {
    setLoading(true);
    await HospitalRepository().getHospitals().then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        setHospitals(Hospitals.fromJson(json.decode(data.data)));
      } else {
        Map<String, dynamic> result = json.decode(data.data);
        setMessage(result.toString());
      }
    });
  }

  Future<void> fetchHospital({String id}) async {
    setLoading(true);
    await HospitalRepository().getHospital(id: id).then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        setHospitals(Hospital.fromJson(json.decode(data.data)));
      } else {
        Map<String, dynamic> result = json.decode(data.data);
        setMessage(result.toString());
      }
    });
  }


  void setHospitals(value) {
    hospitals = value;
    notifyListeners();
  }

  void setHospital(value) {
    hospital = value;
    notifyListeners();
  }

  Hospitals getHospitals() { 
    return hospitals;
  }

  Hospital getHospital() {
    return hospital;
  }

  bool hospitalsExist() {
    return hospitals != null;
  }

  bool hospitalExist() {
    return hospitals != null;
  }

}