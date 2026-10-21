import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocaleStore {
  const AppLocaleStore._();

  static const String _key = 'app_locale';

  static Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_key);
      if (code != null && code.isNotEmpty) {
        LocaleSettings.setLocaleRaw(code, listenToDeviceLocale: false);
      }
    } catch (_) {}
  }

  static Future<void> set(AppLocale locale) async {
    if (LocaleSettings.currentLocale == locale) return;

    LocaleSettings.setLocale(locale, listenToDeviceLocale: false);

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, locale.languageCode);
    } catch (_) {}
  }
}
