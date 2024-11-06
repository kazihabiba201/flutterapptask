
import 'package:flutterapptask/app/config/router/app_router_constants.dart';
import 'package:flutterapptask/app/core/utils/shared_preference.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var errorMessage = ''.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isLoggedIn = false.obs;
  final RxBool _isObscured = true.obs;


  bool get isLoggedIn => _isLoggedIn.value;
  bool get isLoading => _isLoading.value;
  bool get isObscured => _isObscured.value;

  set isLoading(bool value) => _isLoading.value = value;
  set isObscured(bool value) => _isObscured.value = value;



  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    bool loggedIn = await SharedPrefsService.isLoggedIn();
    _isLoggedIn.value = loggedIn;
  }
  void togglePasswordVisibility() => isObscured = !isObscured;


  // Login function
  void login() async {
    isLoading = true;

    if (username.value == 'testuser' && password.value == 'password123') {
      await SharedPrefsService.setLoggedIn(true);
      _isLoggedIn.value = true;
      Get.offNamed(RoutesPaths.home);
      Get.snackbar(
        "Login Successfully!",
        "You have logged in successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }    else {
      errorMessage.value = 'Invalid username or password';

    }

    isLoading = false;
  }


  Future<void> logout() async {
    await SharedPrefsService.clearLoginStatus();
    _isLoggedIn.value = false;
    Get.offNamed(RoutesPaths.login);
  }
}
