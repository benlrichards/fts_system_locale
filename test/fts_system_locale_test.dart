import 'package:flutter_test/flutter_test.dart';
import 'package:fts_system_locale/fts_system_locale.dart';
import 'package:fts_system_locale/src/fts_system_locale_method_channel.dart';
import 'package:fts_system_locale/src/fts_system_locale_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFtsSystemLocalePlatform
    with MockPlatformInterfaceMixin
    implements FtsSystemLocalePlatform {
  @override
  Future<bool?> setLocale(String? locale) => Future.value(true);
}

void main() {
  final FtsSystemLocalePlatform initialPlatform =
      FtsSystemLocalePlatform.instance;

  test('$MethodChannelFtsSystemLocale is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFtsSystemLocale>());
  });

  test('setLocale', () async {
    FtsSystemLocale ftsSystemLocalePlugin = FtsSystemLocale();
    MockFtsSystemLocalePlatform fakePlatform = MockFtsSystemLocalePlatform();
    FtsSystemLocalePlatform.instance = fakePlatform;

    expect(await ftsSystemLocalePlugin.setLocale('en'), true);
  });
}
