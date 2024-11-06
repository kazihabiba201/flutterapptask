import 'package:dio/dio.dart';
import 'package:flutterapptask/app/features/home/data/model/doctor_model.dart';
import 'package:get/get.dart';


class DoctorController extends GetxController {
  var isLoading = true.obs;
  var doctors = <DoctorList>[].obs;
  var onlyAvailable = false.obs;

  @override
  void onInit() {
    fetchDoctorData();
    super.onInit();
  }

  void fetchDoctorData() async {
    try {
      isLoading(true);
      var doctorData = await DoctorService().fetchDoctors();
      if (doctorData != null) {
        doctors.assignAll(doctorData.doctorList);
      }
    } catch (error) {
      print("Error fetching doctors: $error");
    } finally {
      isLoading(false);
    }
  }

  List<DoctorList> get filteredDoctors => onlyAvailable.value
      ? doctors.where((doctor) => doctor.availability == 'Yes').toList()
      : doctors;
}

class DoctorService {
  static const String url = "https://demo-app.medaicloud.live/api/v1/all_user/get_doctor_list";
  final Dio _dio = Dio();

  Future<DoctorModel> fetchDoctors() async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        // No need to use json.decode as Dio automatically parses JSON responses
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