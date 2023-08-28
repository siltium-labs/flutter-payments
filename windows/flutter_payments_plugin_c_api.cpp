#include "include/flutter_payments/flutter_payments_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_payments_plugin.h"

void FlutterPaymentsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_payments::FlutterPaymentsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
