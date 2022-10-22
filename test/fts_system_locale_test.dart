import 'package:flutter_test/flutter_test.dart';
import 'package:fts_system_locale/fts_system_locale.dart';
import 'package:fts_system_locale/fts_system_locale_platform_interface.dart';
import 'package:fts_system_locale/fts_system_locale_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFtsSystemLocalePlatform
    with MockPlatformInterfaceMixin
    implements FtsSystemLocalePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FtsSystemLocalePlatform initialPlatform = FtsSystemLocalePlatform.instance;

  test('$MethodChannelFtsSystemLocale is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFtsSystemLocale>());
  });

  test('getPlatformVersion', () async {
    FtsSystemLocale ftsSystemLocalePlugin = FtsSystemLocale();
    MockFtsSystemLocalePlatform fakePlatform = MockFtsSystemLocalePlatform();
    FtsSystemLocalePlatform.instance = fakePlatform;

    expect(await ftsSystemLocalePlugin.getPlatformVersion(), '42');
  });
}
