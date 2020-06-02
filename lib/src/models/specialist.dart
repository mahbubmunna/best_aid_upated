class SpecialistResponse {
  List<Specialist> specialist;
  String error;

  SpecialistResponse({this.specialist});

  SpecialistResponse.fromJson(Map<String, dynamic> json) {
    if (json['specialist'] != null) {
      specialist = new List<Specialist>();
      json['specialist'].forEach((v) {
        specialist.add(new Specialist.fromJson(v));
      });
      error = "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.specialist != null) {
      data['specialist'] = this.specialist.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SpecialistResponse.withError(String errorValue) {
    this.error = errorValue;
  }
}

class Specialist {
  int id;
  String name;
  String createdAt;
  String updatedAt;

  Specialist({this.id, this.name, this.createdAt, this.updatedAt});

  Specialist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
