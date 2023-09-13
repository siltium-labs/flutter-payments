import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payments/src/manager/data_manager.dart';
import 'package:flutter_payments/src/view/web_view_page.dart';
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
}
// End Plugin class (with Method Channel)---------------------------------------

// Plugin class ----------------------------------------------------------------
class FlutterPayments {
  static final FlutterPayments _instance = FlutterPayments._constructor();
  factory FlutterPayments() {
    return _instance;
  }
  FlutterPayments._constructor();

  static Future<String?> get platformVersion async {
    String? version = await _FlutterPaymentsChannel.platformVersion;
    return version;
  }

  // MERCADO PAGO
  static Future<PaymentResult> payWithMercadoPagoAutomatic({
    required BuildContext context,
    required String publicKey,
    required String preferenceId,
  }) async {
    String? version = await platformVersion;
    PaymentResult paymentResult;
    if (version != null && version.toLowerCase().trim().contains("android")) {
      paymentResult = await _FlutterPaymentsChannel.payWithMercadoPagoCheckout(
        publicKey: publicKey,
        preferenceId: preferenceId,
      );
    } else {
      // ignore: use_build_context_synchronously
      paymentResult = await payWithMercadoPagoWeb(
        context: context,
        preferenceId: preferenceId,
      );
    }

    return paymentResult;
  }

  static Future<Map<String, dynamic>?> payWithMercadoPagoManual({
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

  static Future<PaymentResult> payWithMercadoPagoWeb({
    required BuildContext context,
    required String preferenceId,
  }) async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPage(
            Uri.parse(
              "https://www.mercadopago.com.ar/checkout/v1/redirect?pref_id=${preferenceId}",
            ),
          ),
        ),
      ).then((value) {
        if (value != null) {
          Map<String, dynamic> result = value!;
          //print("Obtuve valor:\n${value.toString()}");
          return const PaymentResult(
            "apro",
          );
          /*
          json['result'] as String,
          json['id'] as int?,
          json['status'] as String?,
          json['statusDetail'] as String?,
          json['paymentMethodId'] as String?,
          json['paymentTypeId'] as String?,
          json['issuerId'] as String?,
          json['installments'] as int?,
          json['captured'] as bool?,
          json['liveMode'] as bool?,
          json['operationType'] as String?,
          json['transactionAmount'] as String?,
          json['errorMessage'] as String?,
          */
        }
      });
    } catch (e) {}

    return const PaymentResult("canceled");
  }

  static Future<String?> createPreferenceIdMercadoPago({
    required String accessToken,
    //body
    required String title,
    required int quantity,
    String currencyId = "ARG",
    required double unitPrice,
    required String name,
    required String email,
  }) async {
    return await DataManager.createPreferenceIdMercadoPago(
      accessToken: accessToken,
      title: title,
      quantity: quantity,
      unitPrice: unitPrice,
      name: name,
      email: email,
    );
  }
}
// End Plugin class ------------------------------------------------------------
