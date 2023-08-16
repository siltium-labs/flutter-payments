#import "MercadoPagoPlugin.h"
#if __has_include(<mercado_pago/mercado_pago-Swift.h>)
#import <mercado_pago/mercado_pago-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mercado_pago-Swift.h"
#endif

@implementation MercadoPagoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMercadoPagoPlugin registerWithRegistrar:registrar];
}
@end
