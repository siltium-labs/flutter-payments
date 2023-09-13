import 'package:flutter/services.dart';
import 'package:flutter_payments/flutter_payments.dart';
import 'package:flutter_payments_example/values/k_colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

import '../../interfaces/i_view_controller.dart';
import '../../managers/page_manager.dart';
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
  String accessTokenTest =
      "TEST-1563356252471753-080709-33fb458ed3d3fc24b9d54032f0e045fd-222344382";
  String? preferenceIDcreated;

  @override
  void initPage({PageArgs? arguments}) async {
    initPlatformState();
    preferenceIDcreated = await FlutterPayments.createPreferenceIdMercadoPago(
      accessToken: accessTokenTest,
      title: "Producto Test",
      quantity: 1,
      unitPrice: 3500.52,
      name: "Jorge Test",
      email: "jmamani@siltium.com",
    );
  }

  @override
  disposePage() {}

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

  void _showResult(PaymentResultModel paymentResultModel) async {
    if (paymentResultModel.errorMessage != null) {
      //print("Pago Error: ${paymentResult.errorMessage}");
      await PageManager().openDefaultAlertPopup(
        title: "Mercado Pago",
        description: "Pago error: ${paymentResultModel.errorMessage}",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel.result.toLowerCase() == "canceled") {
      //print("Pago Cancelado");
      await PageManager().openDefaultAlertPopup(
        title: "Mercado Pago",
        description: "Pago cancelado",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel.status == "rejected") {
      //print("Pago Rechazado");
      await PageManager().openDefaultAlertPopup(
        title: "Mercado Pago",
        description: "Pago rechazado",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel.status == "approved") {
      //print("Pago Aprobado");
      await PageManager().openDefaultAlertPopup(
        title: "Mercado Pago",
        description: "Pago aprobado",
        labelAccept: "Ok",
      );
    }
  }

  void payWithMercadoPagoAutomatic() async {
    PaymentResultModel paymentResultModel =
        await FlutterPayments.payWithMercadoPagoAutomatic(
      context: PageManager().navigatorKey.currentContext!,
      publicKey: publicKeyTest,
      //preferenceId: preferenceIdTest,
      preferenceId: preferenceIDcreated!,
    );

    _showResult(paymentResultModel);
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

  void createPreferenceIdMercadoPago() async {
    String? preferenceID;

    await LoadingPopup(
      context: PageManager().navigatorKey.currentContext!,
      onLoading: FlutterPayments.createPreferenceIdMercadoPago(
        accessToken: accessTokenTest,
        title: "Producto Siltium",
        quantity: 2,
        unitPrice: 5000.99,
        name: "Jorge",
        email: "jmamani@siltium.com",
      ),
      onResult: (String? result) {
        preferenceID = result;
      },
    ).show();

    print("preferenceID: $preferenceID");
  }

  void payWithMercadoPagoWeb() async {
    if (preferenceIDcreated != null && preferenceIDcreated!.isNotEmpty) {
      PaymentResultModel paymentResultModel =
          await FlutterPayments.payWithMercadoPagoWeb(
        context: PageManager().navigatorKey.currentContext!,
        preferenceId: preferenceIDcreated!,
      );

      //_showResult(paymentResultModel);
    }
  }
}
