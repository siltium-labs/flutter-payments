import 'dart:async';
import 'package:flutter/services.dart';
//import 'mercado_pago_platform_interface.dart';
import 'src/payment_result.dart';

export 'src/payment_result.dart';

class MercadoPago {
  /* Future<String?> getPlatformVersion() {
    return MercadoPagoPlatform.instance.getPlatformVersion();
  } */

  static const MethodChannel _channel = MethodChannel('mercado_pago');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<PaymentResult> startCheckout(
    String publicKey,
    String preferenceId,
  ) async {
    Map<String, dynamic>? result =
        await (_channel.invokeMapMethod<String, dynamic>(
      'startCheckout',
      {
        "publicKey": publicKey,
        "preferenceId": preferenceId,
      },
    ));
    return PaymentResult.fromJson(result!);
  }
}
