import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mercado_pago_method_channel.dart';

abstract class MercadoPagoPlatform extends PlatformInterface {
  /// Constructs a MercadoPagoPlatform.
  MercadoPagoPlatform() : super(token: _token);

  static final Object _token = Object();

  static MercadoPagoPlatform _instance = MethodChannelMercadoPago();

  /// The default instance of [MercadoPagoPlatform] to use.
  ///
  /// Defaults to [MethodChannelMercadoPago].
  static MercadoPagoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MercadoPagoPlatform] when
  /// they register themselves.
  static set instance(MercadoPagoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
