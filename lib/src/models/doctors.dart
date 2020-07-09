class DoctorResponse {
  List<Doctors> doctors;
  String error;

  DoctorResponse({this.doctors});

  DoctorResponse.fromJson(Map<String, dynamic> json) {
    if (json['doctors'] != null) {
      doctors = new List<Doctors>();
      json['doctors'].forEach((v) {
        doctors.add(new Doctors.fromJson(v));
      });
      this.error = "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctors != null) {
      data['doctors'] = this.doctors.map((v) => v.toJson()).toList();
    }
    return data;
  }

  DoctorResponse.withError(String errorValue) {
    this.error = errorValue;
  }
}

class Doctors {
  int id;
  int userId;
  int specialistId;
  String name;
  String email;
  String qualification;
  String language;
  String designation;
  String institute;
  String createdAt;
  String updatedAt;
  String photo;

  Doctors(
      {this.id,
      this.userId,
      this.specialistId,
      this.name,
      this.email,
      this.qualification,
      this.language,
      this.designation,
      this.institute,
      this.createdAt,
      this.updatedAt});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    specialistId = json['specialist_id'];
    name = json['name'];
    email = json['email'];
    qualification = json['qualification'];
    language = json['language'];
    designation = json['designation'];
    institute = json['institute'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['specialist_id'] = this.specialistId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['qualification'] = this.qualification;
    data['language'] = this.language;
    data['designation'] = this.designation;
    data['institute'] = this.institute;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo'] = this.photo;
    return data;
  }
}
