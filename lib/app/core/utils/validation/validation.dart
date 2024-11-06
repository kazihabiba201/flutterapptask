import 'package:flutterapptask/app/core/localization/language_constant.dart';
import 'package:get/get.dart';

class EmailFieldValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty && Get.context != null) {
      return translation(Get.context!).emailCantBeEmpty;
    }

    return null;
  }
}

class PasswordFieldValidator {
  static String? validate(String? value) {
    if ((value == null || value.length < 8) && Get.context != null) {
      return translation(Get.context!).passwordShouldHaveAtLeastEightCharacters;
    }
    return null;
  }
}
