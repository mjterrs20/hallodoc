class Hospitals {
  bool success;
  List<Hospital> data;

  Hospitals({this.success, this.data});

  Hospitals.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Hospital>();
      json['data'].forEach((v) {
        data.add(new Hospital.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hospital {
  int id;
  String name;
  String email;
  String phone;
  String address;
  String lat;
  String lng;
  int departmentId;
  int hospitalTypeId;
  List<Schedules> schedules;
  HospitalType hospitalType;

  Hospital(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.lat,
      this.lng,
      this.departmentId,
      this.hospitalTypeId,
      this.schedules,
      this.hospitalType});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    departmentId = json['department_id'];
    hospitalTypeId = json['hospital_type_id'];
    if (json['schedules'] != null) {
      schedules = new List<Schedules>();
      json['schedules'].forEach((v) {
        schedules.add(new Schedules.fromJson(v));
      });
    }
    hospitalType = json['hospital_type'] != null
        ? new HospitalType.fromJson(json['hospital_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['department_id'] = this.departmentId;
    data['hospital_type_id'] = this.hospitalTypeId;
    if (this.schedules != null) {
      data['schedules'] = this.schedules.map((v) => v.toJson()).toList();
    }
    if (this.hospitalType != null) {
      data['hospital_type'] = this.hospitalType.toJson();
    }
    return data;
  }
}

class Schedules {
  int id;
  int hospitalId;
  String day;
  String startAt;
  String endAt;
  List<Doctors> doctors;

  Schedules(
      {this.id,
      this.hospitalId,
      this.day,
      this.startAt,
      this.endAt,
      this.doctors});

  Schedules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospital_id'];
    day = json['day'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    if (json['doctors'] != null) {
      doctors = new List<Doctors>();
      json['doctors'].forEach((v) {
        doctors.add(new Doctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospital_id'] = this.hospitalId;
    data['day'] = this.day;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    if (this.doctors != null) {
      data['doctors'] = this.doctors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctors {
  int id;
  String name;
  String bio;
  String credential;
  String academicAffiliation;
  String imageUrl;
  int spesialistId;
  int userId;
  String type;
  Pivot pivot;

  Doctors(
      {this.id,
      this.name,
      this.bio,
      this.credential,
      this.academicAffiliation,
      this.imageUrl,
      this.spesialistId,
      this.userId,
      this.type,
      this.pivot});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bio = json['bio'];
    credential = json['credential'];
    academicAffiliation = json['academic_affiliation'];
    imageUrl = json['image_url'];
    spesialistId = json['spesialist_id'];
    userId = json['user_id'];
    type = json['type'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['credential'] = this.credential;
    data['academic_affiliation'] = this.academicAffiliation;
    data['image_url'] = this.imageUrl;
    data['spesialist_id'] = this.spesialistId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int scheduleId;
  int doctorId;

  Pivot({this.scheduleId, this.doctorId});

  Pivot.fromJson(Map<String, dynamic> json) {
    scheduleId = json['schedule_id'];
    doctorId = json['doctor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schedule_id'] = this.scheduleId;
    data['doctor_id'] = this.doctorId;
    return data;
  }
}

class HospitalType {
  int id;
  String slug;
  String name;

  HospitalType({this.id, this.slug, this.name});

  HospitalType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    return data;
  }
}
