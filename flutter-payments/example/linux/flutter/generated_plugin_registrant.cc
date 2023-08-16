//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <mercado_pago/mercado_pago_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) mercado_pago_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MercadoPagoPlugin");
  mercado_pago_plugin_register_with_registrar(mercado_pago_registrar);
}
