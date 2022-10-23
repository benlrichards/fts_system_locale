import 'src/fts_system_locale_platform_interface.dart';

class FtsSystemLocale {
  /// {@macro setLocale}
  Future<bool?> setLocale([String? locale]) {
    return FtsSystemLocalePlatform.instance.setLocale(locale);
  }
}
