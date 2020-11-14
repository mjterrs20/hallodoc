class NotifResponse {
  bool success;
  Data data;

  NotifResponse({this.success, this.data});

  NotifResponse.fromJson(Map<dynamic, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String email;
  Null emailVerifiedAt;
  String createdAt;
  String updatedAt;
  Null bannedUntil;
  List<Notifications> notifications;

  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.bannedUntil,
      this.notifications});

  Data.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bannedUntil = json['banned_until'];
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banned_until'] = this.bannedUntil;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int id;
  int userId;
  String title;
  String shortDesc;
  String contentText;
  Null imageUrl;
  int hasRead;
  String tag;
  String date;
  String createdAt;
  String updatedAt;

  Notifications(
      {this.id,
      this.userId,
      this.title,
      this.shortDesc,
      this.contentText,
      this.imageUrl,
      this.hasRead,
      this.tag,
      this.date,
      this.createdAt,
      this.updatedAt});

  Notifications.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    shortDesc = json['short_desc'];
    contentText = json['content_text'];
    imageUrl = json['image_url'];
    hasRead = json['hasRead'];
    tag = json['tag'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['short_desc'] = this.shortDesc;
    data['content_text'] = this.contentText;
    data['image_url'] = this.imageUrl;
    data['hasRead'] = this.hasRead;
    data['tag'] = this.tag;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}