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

class PhoneFieldValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty && Get.context != null) {
      return translation(Get.context!).phoneCantBeEmpty; // Assumes a translation for empty phone number error
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) { // Validates if the phone number has exactly 10 digits
      return translation(Get.context!).invalidPhoneNumber; // Assumes a translation for invalid phone number error
    }
    return null;
  }
}
