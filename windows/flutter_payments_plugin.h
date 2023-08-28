#ifndef FLUTTER_PLUGIN_FLUTTER_PAYMENTS_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_PAYMENTS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_payments {

class FlutterPaymentsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterPaymentsPlugin();

  virtual ~FlutterPaymentsPlugin();

  // Disallow copy and assign.
  FlutterPaymentsPlugin(const FlutterPaymentsPlugin&) = delete;
  FlutterPaymentsPlugin& operator=(const FlutterPaymentsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_payments

#endif  // FLUTTER_PLUGIN_FLUTTER_PAYMENTS_PLUGIN_H_
