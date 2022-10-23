import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fts_system_locale/src/fts_system_locale_method_channel.dart';

void main() {
  MethodChannelFtsSystemLocale platform = MethodChannelFtsSystemLocale();
  const MethodChannel channel = MethodChannel('fts_system_locale');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      final method = methodCall.method;
      if (method == 'setLocale') {
        final locale = methodCall.arguments['locale'];
        return 'locale set to $locale';
      }
      throw MissingPluginException(
        'No implementation found for method $method on channel fts_system_locale',
      );
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('setLocale', () async {
    expect(await platform.setLocale('en'), 'locale set to en');
  });
}
