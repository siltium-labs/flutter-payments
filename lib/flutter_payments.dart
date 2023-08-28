import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flutter_payments.dart';

export 'src/models/mercado_pago/payment_result.dart';
export 'src/components/common/loading_component.dart';
export 'src/view/card_form_widgets.dart';
export 'src/view/credit_card_form_popup.dart';

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

  /* payWithMercadoPago({
    required PaymentMethodEnum paymentMethodEnum,
  }) async {
    switch (paymentMethodEnum) {
      case PaymentMethodEnum.automatic:
        break;
      case PaymentMethodEnum.manual:
        break;
    }
  } */

  // MERCADO PAGO
  static Future<PaymentResult> payWithMercadoPagoAutomatic({
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

  payWithMercadoPagoManual({
    required BuildContext context,
    required String accessToken,
    Color? themeColor,
  }) async {
    return await CreditCardFormPopup(
      context: context,
      accessToken: accessToken,
      themColor: themeColor,
    ).show();
  }

  // MACRO

  // UALA
}
// End Plugin class ------------------------------------------------------------
