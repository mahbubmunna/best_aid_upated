import 'package:bestaid/config/strings.dart';
import 'package:bestaid/src/models/doctors.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:dio/dio.dart';

class DoctorProvider{
  static final _endPointDoctorList = "${api_base_url}doctor/";
  static final Dio _dio = Dio();

  static Future<DoctorResponse> getDoctorList(String id) async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.get(_endPointDoctorList+"1");
      return DoctorResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return DoctorResponse.withError('$error');
    }
  }
}
