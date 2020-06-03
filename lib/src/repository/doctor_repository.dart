import 'package:bestaid/src/models/doctordetails.dart';
import 'package:bestaid/src/models/doctors.dart';
import 'package:bestaid/src/providers/doctor_provider.dart';

class DoctorRepository {
  static Future<DoctorResponse> getDoctorList(String id) {
    return DoctorProvider.getDoctorList(id);
  }

  static Future<DoctorDetails> getDoctorDetails(int id) {
    return DoctorProvider.getDoctorDetails(id);
  }
}
