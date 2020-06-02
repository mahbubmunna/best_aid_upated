import 'package:bestaid/config/strings.dart';
import 'package:bestaid/src/models/specialist.dart';
import 'package:bestaid/src/providers/shared_pref_provider.dart';
import 'package:dio/dio.dart';

class SpecialistProvider{
  static final _endPointSpecialist = "${api_base_url}specialist";
  static final Dio _dio = Dio();

  static Future<SpecialistResponse> getSpecialistList() async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.get(_endPointSpecialist);
      return SpecialistResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return SpecialistResponse.withError('$error');
    }
  }
}

