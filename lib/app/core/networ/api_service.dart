import 'package:dio/dio.dart';
import 'package:flutterapptask/app/features/home/data/model/doctor_model.dart';

class DoctorService {
  static const String url = "https://demo-app.medaicloud.live/api/v1/all_user/get_doctor_list";
  final Dio _dio = Dio();

  Future<DoctorModel> fetchDoctors() async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {

        return DoctorModel.fromJson(response.data);
      } else if (response.statusCode == 403) {
        throw Exception('Access forbidden: 403');
      } else {
        throw Exception('Failed to load doctor data');
      }
    } catch (error) {
      throw Exception('Error fetching doctor data: $error');
    }
  }
}