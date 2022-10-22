#include "include/fts_system_locale/fts_system_locale_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "fts_system_locale_plugin.h"

void FtsSystemLocalePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  fts_system_locale::FtsSystemLocalePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
