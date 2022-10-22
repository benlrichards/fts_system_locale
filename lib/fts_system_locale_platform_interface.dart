import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fts_system_locale_method_channel.dart';

abstract class FtsSystemLocalePlatform extends PlatformInterface {
  /// Constructs a FtsSystemLocalePlatform.
  FtsSystemLocalePlatform() : super(token: _token);

  static final Object _token = Object();

  static FtsSystemLocalePlatform _instance = MethodChannelFtsSystemLocale();

  /// The default instance of [FtsSystemLocalePlatform] to use.
  ///
  /// Defaults to [MethodChannelFtsSystemLocale].
  static FtsSystemLocalePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FtsSystemLocalePlatform] when
  /// they register themselves.
  static set instance(FtsSystemLocalePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> setLocale(String? locale) {
    throw UnimplementedError('setLocale() has not been implemented.');
  }
}
