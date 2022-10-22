//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <fts_system_locale/fts_system_locale_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) fts_system_locale_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FtsSystemLocalePlugin");
  fts_system_locale_plugin_register_with_registrar(fts_system_locale_registrar);
}
