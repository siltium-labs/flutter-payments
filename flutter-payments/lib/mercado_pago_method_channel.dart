import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mercado_pago_platform_interface.dart';

/// An implementation of [MercadoPagoPlatform] that uses method channels.
class MethodChannelMercadoPago extends MercadoPagoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mercado_pago');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
