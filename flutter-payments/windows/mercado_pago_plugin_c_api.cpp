#include "include/mercado_pago/mercado_pago_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "mercado_pago_plugin.h"

void MercadoPagoPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  mercado_pago::MercadoPagoPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
