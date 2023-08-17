import 'dart:async';
import 'package:flutter/services.dart';
import 'src/payment_result.dart';

export 'src/payment_result.dart';

class FlutterPayments {
  static const MethodChannel _channel = MethodChannel('mercado_pago');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<PaymentResult> payWithMercadoPagoCheckout(
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
