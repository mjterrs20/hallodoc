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
      this.spesialist});

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