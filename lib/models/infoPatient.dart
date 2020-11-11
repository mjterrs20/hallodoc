class InfoPatient {
  int id;
  String name;
  int sex;
  String status;

  InfoPatient({this.id, this.name, this.sex, this.status});

  InfoPatient.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.sex = map['sex'];
    this.status = map['status'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['name'] = name;
    map['sex'] = sex;
    map['status'] = status;
    return map;
  }
}
