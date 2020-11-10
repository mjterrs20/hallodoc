class Doctors {
  bool success;
  List<Data> data;

  Doctors({this.success, this.data});

  Doctors.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
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
  List<Schedules> schedules;


  Data(
      {this.id,
      this.name,
      this.bio,
      this.credential,
      this.academicAffiliation,
      this.imageUrl,
      this.spesialistId,
      this.userId,
      this.type,
      this.spesialist,
      this.schedules});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json['schedules'] != null) {
      schedules = new List<Schedules>();
      json['schedules'].forEach((v) {
        schedules.add(new Schedules.fromJson(v));
      });
    }
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


class Schedules {
  int id;
  int hospitalId;
  String day;
  String startAt;
  String endAt;
  Hospital hospital;

  Schedules(
      {this.id,
      this.hospitalId,
      this.day,
      this.startAt,
      this.endAt,
      this.hospital});

  Schedules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospital_id'];
    day = json['day'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospital_id'] = this.hospitalId;
    data['day'] = this.day;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    if (this.hospital != null) {
      data['hospital'] = this.hospital.toJson();
    }
    return data;
  }
}

class Hospital {
  int id;
  String name;

  Hospital({this.id, this.name});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}