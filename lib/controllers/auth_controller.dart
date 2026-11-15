import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  AuthController(this._prefs);
  final SharedPreferences _prefs;

  final RxString username = ''.obs;

  bool get isLoggedIn => _prefs.getBool(AppConfig.loginKey) ?? false;

  @override
  void onInit() {
    username.value = _prefs.getString(AppConfig.usernameKey) ?? '';
    super.onInit();
  }

  Future<bool> login(String user, String pass) async {
    if (user.trim() == AppConfig.nim && pass == AppConfig.password) {
      await _prefs.setBool(AppConfig.loginKey, true);
      await _prefs.setString(AppConfig.usernameKey, user.trim());
      username.value = user.trim();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _prefs.remove(AppConfig.loginKey);
    await _prefs.remove(AppConfig.usernameKey);
    username.value = '';
    Get.offAllNamed(AppRoutes.login);
  }
}
