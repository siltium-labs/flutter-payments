#ifndef FLUTTER_PLUGIN_MERCADO_PAGO_PLUGIN_H_
#define FLUTTER_PLUGIN_MERCADO_PAGO_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace mercado_pago {

class MercadoPagoPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MercadoPagoPlugin();

  virtual ~MercadoPagoPlugin();

  // Disallow copy and assign.
  MercadoPagoPlugin(const MercadoPagoPlugin&) = delete;
  MercadoPagoPlugin& operator=(const MercadoPagoPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace mercado_pago

#endif  // FLUTTER_PLUGIN_MERCADO_PAGO_PLUGIN_H_
