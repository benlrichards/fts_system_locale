import 'fts_system_locale_platform_interface.dart';

class FtsSystemLocale {
  Future<String?> getPlatformVersion() {
    return FtsSystemLocalePlatform.instance.getPlatformVersion();
  }

  Future<String?> setLocale([String? locale]) {
    return FtsSystemLocalePlatform.instance.setLocale(locale);
  }
}
