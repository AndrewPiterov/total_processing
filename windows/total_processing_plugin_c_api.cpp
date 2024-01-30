#include "include/total_processing/total_processing_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "total_processing_plugin.h"

void TotalProcessingPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  total_processing::TotalProcessingPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
