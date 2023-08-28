#import "FlutterPaymentsPlugin.h"
#if __has_include(<flutter_payments/flutter_payments-Swift.h>)
#import <flutter_payments/flutter_payments-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_payments-Swift.h"
#endif

@implementation FlutterPaymentsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPaymentsPlugin registerWithRegistrar:registrar];
}
@end
