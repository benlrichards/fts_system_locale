#import "FtsSystemLocalePlugin.h"
#if __has_include(<fts_system_locale/fts_system_locale-Swift.h>)
#import <fts_system_locale/fts_system_locale-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fts_system_locale-Swift.h"
#endif

@implementation FtsSystemLocalePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFtsSystemLocalePlugin registerWithRegistrar:registrar];
}
@end
