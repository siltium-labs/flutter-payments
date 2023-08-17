import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_payments_platform_interface.dart';

/// An implementation of [FlutterPaymentsPlatform] that uses method channels.
class MethodChannelFlutterPayments extends FlutterPaymentsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mercado_pago');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
