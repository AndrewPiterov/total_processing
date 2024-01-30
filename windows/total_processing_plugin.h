#ifndef FLUTTER_PLUGIN_TOTAL_PROCESSING_PLUGIN_H_
#define FLUTTER_PLUGIN_TOTAL_PROCESSING_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace total_processing {

class TotalProcessingPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  TotalProcessingPlugin();

  virtual ~TotalProcessingPlugin();

  // Disallow copy and assign.
  TotalProcessingPlugin(const TotalProcessingPlugin&) = delete;
  TotalProcessingPlugin& operator=(const TotalProcessingPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace total_processing

#endif  // FLUTTER_PLUGIN_TOTAL_PROCESSING_PLUGIN_H_
