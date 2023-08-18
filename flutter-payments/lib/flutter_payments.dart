import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'src/models/mercado_pago/payment_result.dart';
import 'package:http/http.dart' as http;

export 'src/models/mercado_pago/payment_result.dart';

// Plugin class (with Method Channel) ------------------------------------------
class _FlutterPaymentsChannel {
  static const MethodChannel _channel =
      MethodChannel('flutter_payments_method_channel');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // MERCADO PAGO
  static Future<PaymentResult> payWithMercadoPagoCheckout({
    required String publicKey,
    required String preferenceId,
  }) async {
    Map<String, dynamic>? result =
        await (_channel.invokeMapMethod<String, dynamic>(
      'startCheckoutWithMercadoPago',
      {
        "publicKey": publicKey,
        "preferenceId": preferenceId,
      },
    ));
    return PaymentResult.fromJson(result!);
  }

  // MACRO

  // UALA
}
// End Plugin class (with Method Channel)---------------------------------------

// Plugin class ----------------------------------------------------------------
class FlutterPayments {
  //String _publicKey = "YOUR KEY";
  //String _preferenceId = "YOUR ID";

  static final FlutterPayments _instance = FlutterPayments._constructor();
  factory FlutterPayments() {
    return _instance;
  }
  FlutterPayments._constructor();

  /* paymentsInit({
    //GENERAL
    required String publicKey,
    required String preferenceId,
  }) {
    _publicKey = publicKey;
    _preferenceId = preferenceId;
  } */

  static Future<String?> get platformVersion async {
    String? version = await _FlutterPaymentsChannel.platformVersion;
    return version;
  }

  // MERCADO PAGO
  static Future<PaymentResult> payWithMercadoPagoCheckout({
    required String publicKey,
    required String preferenceId,
  }) async {
    PaymentResult paymentResult =
        await _FlutterPaymentsChannel.payWithMercadoPagoCheckout(
      publicKey: publicKey,
      preferenceId: preferenceId,
    );
    return paymentResult;
  }

  static Future<String> getTockenCardMercadoPago({
    required String accessToken,
    required String cardNumber,
    required String cardHolder,
    required String expirationMonth,
    required String expirationYear,
    required String cvv,
  }) async {
    final response = await http.post(
      Uri.parse('https://api.mercadopago.com/v1/card_tokens'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: {
        "card_number": cardNumber,
        "security_code": cvv,
        "expiration_month": expirationMonth,
        "expiration_year": expirationYear,
        "cardholder": ({"name": cardHolder}).toString(),
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody["id"];
    } else {
      throw Exception('Error tokenizing card');
    }
  }

  // MACRO

  // UALA
}
// End Plugin class ------------------------------------------------------------
