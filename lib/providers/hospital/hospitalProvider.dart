import 'dart:convert';

import 'package:hallodoc/models/hospital.dart';
import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/hospital/hospitalRepository.dart';

class HospitalProvider extends BaseProvider {
  
  HospitalsResponse hospitals;

  Future<void> fetchHospitals() async {
    setLoading(true);
    await HospitalRepository().getHospitals().then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        setHospitals(HospitalsResponse.fromJson(json.decode(data.data)));
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
        return json.decode(data.data);
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

  HospitalsResponse getHospitals() { 
    return hospitals;
  }

  bool hospitalsExist() {
    return hospitals != null;
  }

  bool hospitalExist() {
    return hospitals != null;
  }

}