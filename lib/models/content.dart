class Content {
  bool success;
  List<Data> data;

  Content({this.success, this.data});

  Content.fromJson(Map<String, dynamic> json) {
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
  String title;
  String desc;
  String imageUrl;
  String date;
  String category;
  String name;
  String type;

  Data(
      {this.title,
      this.desc,
      this.imageUrl,
      this.date,
      this.category,
      this.name,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    desc = json['desc'] ?? "";
    imageUrl = json['image_url'] ?? json['img_url'];
    date = json['date'] ?? null;
    category = json['category'] ?? json['name'];
    name = json['name'] ?? "";
    type = json['type'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['image_url'] = this.imageUrl;
    data['date'] = this.date;
    data['category'] = this.category;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }

  bool isNews() {
    return this.category == "Berita";
  }

  bool isPromotion() {
    return this.category == "Promo";
  }

  bool isFacility() {
    return this.category == "Fasilitas";
  }

  bool isPartner() {
    return this.category == "Partner";
  }

  bool isEvent() {
    return this.category == "Event";
  }

  bool isServices() {
    return this.category == "Layanan";
  }
}