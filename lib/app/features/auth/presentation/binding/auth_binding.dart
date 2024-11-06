import 'package:flutterapptask/app/features/auth/presentation/controller/login_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => LoginController());

}