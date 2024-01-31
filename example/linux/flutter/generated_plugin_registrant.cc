//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <total_processing/total_processing_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) total_processing_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "TotalProcessingPlugin");
  total_processing_plugin_register_with_registrar(total_processing_registrar);
}
