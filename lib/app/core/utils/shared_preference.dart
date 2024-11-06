import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _isLoggedInKey = 'isLoggedIn';

  // SharedPreferences instance
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get SharedPreferences instance
  static Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // Get login status
  static Future<bool> isLoggedIn() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Set login status
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_isLoggedInKey, value);
  }

  // Clear login status
  static Future<void> clearLoginStatus() async {
    final prefs = await _getPrefs();
    await prefs.remove(_isLoggedInKey);
  }
}
