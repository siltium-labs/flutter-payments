import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_payments_method_channel.dart';

abstract class FlutterPaymentsPlatform extends PlatformInterface {
  /// Constructs a MercadoPagoPlatform.
  FlutterPaymentsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPaymentsPlatform _instance = MethodChannelFlutterPayments();

  /// The default instance of [FlutterPaymentsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPayments].
  static FlutterPaymentsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPaymentsPlatform] when
  /// they register themselves.
  static set instance(FlutterPaymentsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
