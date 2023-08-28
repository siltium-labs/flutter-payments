import 'package:flutter/services.dart';
import 'package:flutter_payments/flutter_payments.dart';
import 'package:flutter_payments_example/values/k_colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import '../../interfaces/i_view_controller.dart';
import '../../managers/page_manager.dart';
import '../../utils/functions_utils.dart';
import '../../utils/page_args.dart';
import '../popups/loading_popup.dart';

class HomePageController extends ControllerMVC implements IViewController {
  static late HomePageController _this;

  factory HomePageController() {
    _this = HomePageController._();
    return _this;
  }

  static HomePageController get con => _this;
  PageArgs? args;
  HomePageController._();

  bool isLoading = false;
  String? platformVersion = 'Unknown';

  // const publicKey = "YOUR KEY";
  // const preferenceId = "YOUR ID";
  // const accessTokenTest = "YOUR ACCESS TOKEN";
  String publicKeyTest = "TEST-81d8a608-abf0-4d87-8575-edee2427d378";
  String preferenceIdTest = "222344382-b941a00f-b511-4e1d-bac5-d74f78586c09";
  String accessTokenTest =
      "TEST-1563356252471753-080709-33fb458ed3d3fc24b9d54032f0e045fd-222344382";

  @override
  void initPage({PageArgs? arguments}) {
    initPlatformState();
  }

  @override
  disposePage() {}

  /* Future<Map<String, dynamic>> createPreference() async {
    Map<String, dynamic> preference = {
      "items": [
        {
          "title": "Test",
          "quantity": 1,
          "currency_id": "ARG",
          "unit_price": 3500.52
        }
      ],
      "payer": {
        "name": "Jorge",
        "email": "jmamani@gmail.com",
      },
      "payment_methods": {
        "exclude_payment_types": [
          //Tarjeta de crédito: "credit_card"
          //Tarjeta de débito: "debit_card"
          //Efectivo (pago en puntos de pago, como tiendas locales): "ticket"
          //Transferencia bancaria: "bank_transfer"

          {"id": "ticket"},
          //{"id": "debit_card"},
        ],
      }

      // Se puede quitar ek boton de "Promociones" agregando a este json "additional_info"
    };
    Map<String, dynamic> result = await mp.createPreference(preference);
    return result;
  }

  String _getPreferenceId(Map<String, dynamic> preference) {
    String preferenceId = preference["response"]["id"];
    //print("PreferenceId: $preferenceId");

    return preferenceId;
  }

  Future<String> getPreferenceId() async {
    Map<String, dynamic> result = await createPreference();
    String preferenceId = _getPreferenceId(result);
    //print("PreferenceId: $preferenceId");

    return preferenceId;
  } */

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await FlutterPayments.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    setState(() {
      platformVersion = platformVersion;
    });
  }

  Future<void> getPreferenceId() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  void pay() async {
    await LoadingPopup(
      context: PageManager().navigatorKey.currentContext!,
      onLoading: getPreferenceId(),
      onError: (err) {
        _onError(err);
      },
      onResult: (data) {
        _onResultData(data);
      },
    ).show();
  }

  void _onError(dynamic err) {
    showToast(
      context: PageManager().navigatorKey.currentContext!,
      message: "Error",
    );
  }

  void _onResultData(dynamic data) async {}

  void payWithMercadoPagoAutomatic() async {
    PaymentResult paymentResult =
        await FlutterPayments.payWithMercadoPagoAutomatic(
      publicKey: publicKeyTest,
      preferenceId: preferenceIdTest,
    );

    if (paymentResult.errorMessage != null) {
      //print("Pago Error: ${paymentResult.errorMessage}");
      await PageManager().openDefaultAlertPopup(
        title: "Mercado Pago",
        description: "Pago error: ${paymentResult.errorMessage}",
        labelAccept: "Ok",
      );
    } else if (paymentResult.result.toLowerCase() == "canceled") {
      //print("Pago Cancelado");
      await PageManager().openDefaultAlertPopup(
        title: "Mercado Pago",
        description: "Pago cancelado",
        labelAccept: "Ok",
      );
    } else if (paymentResult.status == "rejected") {
      //print("Pago Rechazado");
      await PageManager().openDefaultAlertPopup(
        title: "Mercado Pago",
        description: "Pago rechazado",
        labelAccept: "Ok",
      );
    } else if (paymentResult.status == "approved") {
      //print("Pago Aprobado");
      await PageManager().openDefaultAlertPopup(
        title: "Mercado Pago",
        description: "Pago aprobado",
        labelAccept: "Ok",
      );
    }
  }

  void payWithMercadoPagoManual() async {
    Map<String, dynamic>? result =
        await FlutterPayments.payWithMercadoPagoManual(
      context: PageManager().navigatorKey.currentContext!,
      accessToken: accessTokenTest,
      themeColor: kPrimary,
    );

    print("Obtuve resultado: $result");
  }
}
