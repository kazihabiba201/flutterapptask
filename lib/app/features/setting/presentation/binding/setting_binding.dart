import 'package:flutterapptask/app/features/auth/presentation/controller/login_controller.dart';
import 'package:flutterapptask/app/features/setting/presentation/controller/doctor_list_controller.dart';
import 'package:get/get.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => LoginController());

}