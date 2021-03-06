class DoctorDetails {
  Doctor doctor;
  String error;

  DoctorDetails({this.doctor});

  DoctorDetails.fromJson(Map<String, dynamic> json) {
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    error = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    return data;
  }

  DoctorDetails.withError(String error) {
    this.error = error;
  }
}

class Doctor {
  int id;
  int userId;
  int specialistId;
  String name;
  String email;
  String phone;
  String qualification;
  String language;
  String designation;
  String institute;
  String createdAt;
  String updatedAt;
  String code;
  String type;
  String about;
  String specialistOn;
  String photo;
  Specialist specialist;

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    specialistId = json['specialist_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    qualification = json['qualification'];
    language = json['language'];
    designation = json['designation'];
    institute = json['institute'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    about = json['about'];
    photo = json['photo'];
    specialistOn = json['specialist_on'];
    specialist = json['specialist'] != null
        ? new Specialist.fromJson(json['specialist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['user_id'] = this.userId;
    data['specialist_id'] = this.specialistId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['qualification'] = this.qualification;
    data['language'] = this.language;
    data['designation'] = this.designation;
    data['institute'] = this.institute;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['about'] = this.about;
    data['specialist_on'] = this.specialistOn;
    data['photo'] = this.photo;
    if (this.specialist != null) {
      data['specialist'] = this.specialist.toJson();
    }
    return data;
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
