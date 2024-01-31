import 'package:shared_preferences/shared_preferences.dart';
//singleton
abstract class PreferencesService {
  static SharedPreferences? prefs;
  static bool checkUser() {
    return prefs?.getBool('isLogin') ?? false;
  }
}
