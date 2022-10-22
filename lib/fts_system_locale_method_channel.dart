import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fts_system_locale_platform_interface.dart';

/// An implementation of [FtsSystemLocalePlatform] that uses method channels.
class MethodChannelFtsSystemLocale extends FtsSystemLocalePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fts_system_locale');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> setLocale(String? locale) async {
    final version = await methodChannel.invokeMethod<String>('setLocale', {'locale': locale});
    return version;
  }
}
