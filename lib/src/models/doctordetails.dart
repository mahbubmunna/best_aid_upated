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

  Doctor(
      {this.id,
      this.userId,
      this.specialistId,
      this.name,
      this.email,
      this.phone,
      this.qualification,
      this.language,
      this.designation,
      this.institute,
      this.createdAt,
      this.updatedAt});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    specialistId = json['specialist_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    qualification = json['qualification'];
    language = json['language'];
    designation = json['designation'];
    institute = json['institute'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['specialist_id'] = this.specialistId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['qualification'] = this.qualification;
    data['language'] = this.language;
    data['designation'] = this.designation;
    data['institute'] = this.institute;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
