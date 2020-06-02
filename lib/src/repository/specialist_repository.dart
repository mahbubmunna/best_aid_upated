import 'package:bestaid/src/models/specialist.dart';
import 'package:bestaid/src/providers/specialist_provider.dart';

class SpecialistRepository {
  static Future<SpecialistResponse> getSpecialistList() {
    return SpecialistProvider.getSpecialistList();
  }
}
