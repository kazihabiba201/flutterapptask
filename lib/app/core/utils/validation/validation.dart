class EmailFieldValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email can\'t be empty';
    }

    return null;
  }
}

class PasswordFieldValidator {
  static String? validate(String? value) {
    return (value == null || value.length < 8) ? 'Password should have at least 8 characters.' : null;
  }
}
