import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payments/src/manager/data_manager.dart';
import 'package:flutter_payments/src/models/mercado_pago/payment_result_web_model.dart';
import 'package:flutter_payments/src/view/web_view_page.dart';
import 'flutter_payments.dart';

export 'src/models/mercado_pago/payment_result_model.dart';
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
  static Future<PaymentResultModel> payWithMercadoPagoCheckout({
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
    return PaymentResultModel.fromJson(result!);
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
  static Future<PaymentResultModel> payWithMercadoPagoAutomatic({
    required BuildContext context,
    required String publicKey,
    required String preferenceId,
  }) async {
    String? version = await platformVersion;
    PaymentResultModel paymentResultModel;
    if (version != null && version.toLowerCase().trim().contains("android")) {
      paymentResultModel =
          await _FlutterPaymentsChannel.payWithMercadoPagoCheckout(
        publicKey: publicKey,
        preferenceId: preferenceId,
      );
    } else {
      // ignore: use_build_context_synchronously
      paymentResultModel = await payWithMercadoPagoWeb(
        context: context,
        preferenceId: preferenceId,
      );
    }

    return paymentResultModel;
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

  static Future<PaymentResultModel> payWithMercadoPagoWeb({
    required BuildContext context,
    required String preferenceId,
  }) async {
    try {
      dynamic value = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPage(
            Uri.parse(
              "https://www.mercadopago.com.ar/checkout/v1/redirect?pref_id=${preferenceId}",
            ),
          ),
        ),
      );

      if (value != null) {
        Map<String, dynamic> result = value!;
        PaymentResultWebModel paymentResultWeb =
            PaymentResultWebModel.fromJson(result);

        if (paymentResultWeb.status != null) {
          return PaymentResultModel(
            result: "done",
            status: paymentResultWeb.status,
          );
        }

        // Automatic APRO
        /*
          captured: null
          errorMessage: null
          id: 1314782092
          installments: 1
          issuerId: null
          liveMode: null
          operationType: "regular_payment"
          paymentMethodId: "visa"
          paymentTypeId: "credit_card"
          result: "done"
          status: "approved"
          statusDetail:"accredited"
          transactionAmount: "3500.52"
          */

        // Automatic OTHE
        /*
          captured: null
          errorMessage: null
          id: 1314784246
          installments: 2
          issuerId: null
          liveMode: null
          operationType: "regular_payment"
          paymentMethodId: "visa"
          paymentTypeId: "credit_card"
          result: "done"
          status: "rejected"
          statusDetail: "cc_rejected_other_reason"
          transactionAmount: "3500.52" 
          */

        // Automatic CONT
        /*
          captured: null
          errorMessage: null
          id: 1314784334
          installments: 3
          issuerId: null
          liveMode: null
          operationType: "regular_payment"
          paymentMethodId: "visa"
          paymentTypeId: "credit_card"
          result: "done"
          status: "in_process"
          statusDetail: "pending_contingency"
          transactionAmount: "3500.52" 
          */
      }
    } catch (e) {
      return PaymentResultModel(
        result: "canceled",
        errorMessage: e.toString(),
      );
    }

    return PaymentResultModel(result: "canceled");
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
