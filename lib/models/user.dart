class UserResponse {
  bool success;
  User user;

  UserResponse({this.success, this.user});

  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['data'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String createdAt;
  String updatedAt;
  dynamic bannedUntil;
  List<Roles> roles;
  bool isDoctor;
  bool isPatient;
  String sex;
  String phone;
  dynamic imageUrl;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.bannedUntil,
      this.roles,
      this.isDoctor,
      this.isPatient,
      this.sex,
      this.phone, 
      this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bannedUntil = json['banned_until'];
    if (json['roles'] != null) {
      roles = new List<Roles>();
      json['roles'].forEach((v) {
        roles.add(new Roles.fromJson(v));
      });
    }
    isDoctor = json['isDoctor'];
    isPatient = json['isPatient'];
    sex = json['sex'];
    phone = json['phone'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banned_until'] = this.bannedUntil;
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    data['isDoctor'] = this.isDoctor;
    data['isPatient'] = this.isPatient;
    data['sex'] = this.sex;
    data['phone'] = this.phone;
    return data;
  }
}

class Roles {
  String name;
  String slug;
  Pivot pivot;

  Roles({this.name, this.slug, this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int userId;
  int roleId;

  Pivot({this.userId, this.roleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    return data;
  }
}
