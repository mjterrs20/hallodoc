class BookingList {
  bool success;
  List<Bookings> data;

  BookingList({this.success, this.data});

  BookingList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Bookings>();
      json['data'].forEach((v) {
        data.add(new Bookings.fromJson(v));
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

class Bookings {
  int id;
  int doctorId;
  int hospitalId;
  int patientId;
  String message;
  String bookingFor;
  int isActive;
  String date;
  String bookingCode;
  String status;
  Doctor doctor;
  BookingsHospital hospital;

  Bookings(
      {this.id,
      this.doctorId,
      this.hospitalId,
      this.patientId,
      this.message,
      this.bookingFor,
      this.isActive,
      this.date,
      this.bookingCode,
      this.status,
      this.doctor,
      this.hospital});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    hospitalId = json['hospital_id'];
    patientId = json['patient_id'];
    message = json['message'];
    bookingFor = json['booking_for'];
    isActive = json['is_active'];
    date = json['date'];
    bookingCode = json['booking_code'];
    status = json['status'];
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    hospital = json['hospital'] != null
        ? new BookingsHospital.fromJson(json['hospital'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['hospital_id'] = this.hospitalId;
    data['patient_id'] = this.patientId;
    data['message'] = this.message;
    data['booking_for'] = this.bookingFor;
    data['is_active'] = this.isActive;
    data['date'] = this.date;
    data['booking_code'] = this.bookingCode;
    data['status'] = this.status;
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    if (this.hospital != null) {
      data['hospital'] = this.hospital.toJson();
    }
    return data;
  }
}

class Doctor {
  int id;
  String name;
  String bio;
  String credential;
  String academicAffiliation;
  String imageUrl;
  int spesialistId;
  int userId;
  String type;
  Spesialist spesialist;

  Doctor(
      {this.id,
      this.name,
      this.bio,
      this.credential,
      this.academicAffiliation,
      this.imageUrl,
      this.spesialistId,
      this.userId,
      this.type,
      this.spesialist});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bio = json['bio'];
    credential = json['credential'];
    academicAffiliation = json['academic_affiliation'];
    imageUrl = json['image_url'];
    spesialistId = json['spesialist_id'];
    userId = json['user_id'];
    type = json['type'];
    spesialist = json['spesialist'] != null
        ? new Spesialist.fromJson(json['spesialist'])
        : null;
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
    if (this.spesialist != null) {
      data['spesialist'] = this.spesialist.toJson();
    }
    return data;
  }
}

class Spesialist {
  int id;
  String slug;
  String name;
  String description;

  Spesialist({this.id, this.slug, this.name, this.description});

  Spesialist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class BookingsHospital {
  int id;
  String name;
  String email;
  String phone;
  String address;
  String lat;
  String lng;
  int departmentId;
  int hospitalTypeId;

  BookingsHospital(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.lat,
      this.lng,
      this.departmentId,
      this.hospitalTypeId});

  BookingsHospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    departmentId = json['department_id'];
    hospitalTypeId = json['hospital_type_id'];
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
    return data;
  }
}
