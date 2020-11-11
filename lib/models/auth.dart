class Auth {
  dynamic success;
  Data data;

  Auth({this.success, this.data});

  Auth.fromJson(Map<dynamic, dynamic> json) {
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
  dynamic token;
  dynamic name;

  Data({this.token, this.name});

  Data.fromJson(Map<dynamic, dynamic> json) {
    token = json['token'];
    name = json['name'] ?? "";
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['token'] = this.token;
    data['name'] = this.name;
    return data;
  }
}