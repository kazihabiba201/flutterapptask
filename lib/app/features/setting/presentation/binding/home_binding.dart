import 'package:flutterapptask/app/features/setting/presentation/controller/doctor_list_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => DoctorController());

}