class BookingDetailResponse {
  bool success;
  Data data;

  BookingDetailResponse({this.success, this.data});

  BookingDetailResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
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
  Hospital hospital;
  List<BookingPatientInformation> bookingPatientInformation;
  Patient patient;
  Doctor doctor;

  Data(
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
      this.hospital,
      this.bookingPatientInformation,
      this.patient,
      this.doctor});

  Data.fromJson(Map<String, dynamic> json) {
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
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
    if (json['booking_patient_information'] != null) {
      bookingPatientInformation = new List<BookingPatientInformation>();
      json['booking_patient_information'].forEach((v) {
        bookingPatientInformation
            .add(new BookingPatientInformation.fromJson(v));
      });
    }
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
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
    if (this.hospital != null) {
      data['hospital'] = this.hospital.toJson();
    }
    if (this.bookingPatientInformation != null) {
      data['booking_patient_information'] =
          this.bookingPatientInformation.map((v) => v.toJson()).toList();
    }
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
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

  Hospital(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.lat,
      this.lng,
      this.departmentId,
      this.hospitalTypeId});

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

class BookingPatientInformation {
  int id;
  int bookingId;
  String name;
  String status;
  String sex;
  String createdAt;
  String updatedAt;

  BookingPatientInformation(
      {this.id,
      this.bookingId,
      this.name,
      this.status,
      this.sex,
      this.createdAt,
      this.updatedAt});

  BookingPatientInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    name = json['name'];
    status = json['status'];
    sex = json['sex'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['sex'] = this.sex;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Patient {
  int id;
  int userId;
  String address;
  String phone;
  String sex;
  String imageUrl;

  Patient(
      {this.id,
      this.userId,
      this.address,
      this.phone,
      this.sex,
      this.imageUrl});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    phone = json['phone'];
    sex = json['sex'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['sex'] = this.sex;
    data['image_url'] = this.imageUrl;
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
  Spesialist spesialist;
  String type;

  Doctor(
      {this.id,
      this.name,
      this.bio,
      this.credential,
      this.academicAffiliation,
      this.imageUrl,
      this.spesialistId,
      this.userId,
      this.spesialist,
      this.type});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bio = json['bio'];
    credential = json['credential'];
    academicAffiliation = json['academic_affiliation'];
    imageUrl = json['image_url'];
    spesialistId = json['spesialist_id'];
    userId = json['user_id'];
    spesialist = json['spesialist'] != null
        ? new Spesialist.fromJson(json['spesialist'])
        : null;
    type = json['type'];
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
    if (this.spesialist != null) {
      data['spesialist'] = this.spesialist.toJson();
    }
    data['type'] = this.type;
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
