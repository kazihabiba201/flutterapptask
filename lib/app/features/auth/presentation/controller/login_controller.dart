
import 'package:flutter/material.dart';
import 'package:flutterapptask/app/config/router/app_router_constants.dart';
import 'package:flutterapptask/app/core/localization/language_constant.dart';
import 'package:flutterapptask/app/core/utils/shared_preference.dart';
import 'package:flutterapptask/main.dart';
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
  void login(BuildContext context) async {
    isLoading = true;

    if (username.value == 'testuser' && password.value == 'password123') {
      await SharedPrefsService.setLoggedIn(true);
      _isLoggedIn.value = true;
      Get.offNamed(RoutesPaths.home);
      errorMessage.value = '';
      Get.snackbar(
        "Login Successfully!",
        "You have logged in successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }    else {
      errorMessage.value = translation(context).invalidUsernameOrPassword;

    }

    isLoading = false;
  }


  Future<void> logout() async {
    await SharedPrefsService.clearLoginStatus();
      clearLanguagePreference();
    _isLoggedIn.value = false;
    MyApp.setLocale(Get.context!, Locale('en', 'US'));
    Get.offNamed(RoutesPaths.login);
  }
}
