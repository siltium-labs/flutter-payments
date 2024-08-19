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

  void _showResult({
    required String title,
    required PaymentResultModel paymentResultModel,
  }) async {
    if (paymentResultModel.errorMessage != null) {
      //print("Pago Error: ${paymentResult.errorMessage}");
      await PageManager().openDefaultAlertPopup(
        title: title,
        description: "Pago error: ${paymentResultModel.errorMessage}",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel.result.toLowerCase() == "canceled") {
      //print("Pago Cancelado");
      await PageManager().openDefaultAlertPopup(
        title: title,
        description: "Pago cancelado",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel.status == "rejected") {
      //print("Pago Rechazado");
      await PageManager().openDefaultAlertPopup(
        title: title,
        description: "Pago rechazado",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel.status == "approved") {
      //print("Pago Aprobado");
      await PageManager().openDefaultAlertPopup(
        title: title,
        description: "Pago aprobado",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel.status == "in_process") {
      //print("Pago pendiente");
      await PageManager().openDefaultAlertPopup(
        title: title,
        description: "Pago pendiente",
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

    _showResult(
      title: "Mercado Pago SDK",
      paymentResultModel: paymentResultModel,
    );
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
        externalReference: "12345678",
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

      _showResult(
        title: "Mercado Pago Web",
        paymentResultModel: paymentResultModel,
      );
    }
  }

  void payWithTotalCoinWeb() async {
    if (preferenceIDcreated != null && preferenceIDcreated!.isNotEmpty) {
      PaymentResultModel paymentResultModel =
          await FlutterPayments.payWithTotalCoinWeb(
        context: PageManager().navigatorKey.currentContext!,
        preferenceId: "35f7e654-6ec9-4a0e-9fb3-a3f5ebcee8d7",
      );

      _showResult(
        title: "Total Coin Web",
        paymentResultModel: paymentResultModel,
      );
    }
  }

  void payWithMacroClickWeb() async {
    PaymentResultModel paymentResultModel =
        await FlutterPayments.payWithMacroClickWeb(
      context: PageManager().navigatorKey.currentContext!,
      url: "https://sandboxpp.asjservicios.com.ar/",
      body:
          "Hash=035a22333034bef0853987ec9a3534d3868f9ead708c8f8163e1d49db0c0784a&Comercio=a6c51c8e-cfa3-4c0c-ba5e-0c0af4cbd284&SucursalComercio=yVLg%2B6d7LlIKDYeeM0RA4B%2FR9%2F1ssNRhTqI5NtJiSgg%3D&TransaccionComercioId=transaction-dummy__2024-08-19_15-59-09&ClientData.NombreApellido=FirstName+LastName&CallbackSuccess=eeugs8giG9kcLAzv2eOGlemqC2P5M8gO2XSke9fGOyID2iVpIowePqeSlfNPF2Iw&CallbackCancel=jAp7BTumZnKx3xX%2FY%2BracneTlbxI0zCLmPj0KJOEVdUil923cw0bHYftXiDZr4%2B3&Monto=LKwyuSrWUn0bC2dAl9UQU1xwXr%2FHRIIUvxFGdqK%2FCLw%3D&Informacion=5gFtIjATQDrXjfU3is8XU9rjfKIiLOUgepy%2FkrCIMRqxVFejZspFmE12mPXKSWuv&ClientData.CUIT=11123456784&Producto%5B0%5D=Garrafa+15kg&MontoProducto%5B0%5D=30000",
    );

    _showResult(
      title: "Macro Click Web",
      paymentResultModel: paymentResultModel,
    );
  }

  void payWithMacroClickWebPopup() async {
    PaymentResultModel paymentResultModel =
        await FlutterPayments.payWithMacroClickWebPopup(
      context: PageManager().navigatorKey.currentContext!,
      url: "https://sandboxpp.asjservicios.com.ar/",
      body:
          "Hash=035a22333034bef0853987ec9a3534d3868f9ead708c8f8163e1d49db0c0784a&Comercio=a6c51c8e-cfa3-4c0c-ba5e-0c0af4cbd284&SucursalComercio=njwkDlzltSCSTWb3mdaxnzvHMu50S0nhPdkgvjTDMBY%3D&TransaccionComercioId=transaction-dummy__2024-08-16_16-29-29&ClientData.NombreApellido=FirstName+LastName&CallbackSuccess=AqXbtrzfpQyn2lkbk2GTSzcLdM6fkD%2By6xYDZlh3b3kmQyhjoyPcky0E1p9O6pn5&CallbackCancel=bPTJF%2FZ4TpVNg4irH52sFLyEHRSWwr3lh3W11hVmoJaSPqC8o%2BZqH3Y96VO%2BmNO1&Monto=D95p2IqUobVcxbu%2F9RwBJ5c2GjuMHVq%2F7861f7DAd1c%3D&Informacion=rtzbiYjbAfCwN9hACA6N3xDC4UTd8OLtdPG6iqBVIqiop4I3kCP%2FFPUQu8VG9W0m&ClientData.CUIT=11123456784&Producto%5B0%5D=Garrafa+15kg&MontoProducto%5B0%5D=30000",
      isCancellable: true,
      enablePhysicalBackButton: false,
    );

    _showResult(
      title: "Macro Click Web",
      paymentResultModel: paymentResultModel,
    );
  }
}
