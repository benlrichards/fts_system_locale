import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fts_system_locale/fts_system_locale_method_channel.dart';

void main() {
  MethodChannelFtsSystemLocale platform = MethodChannelFtsSystemLocale();
  const MethodChannel channel = MethodChannel('fts_system_locale');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
