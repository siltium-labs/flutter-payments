import 'dart:developer';

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
  String publicKeyTest = "TEST-66ed404b-ae56-47de-99ae-76a5e53599a9";
  String accessTokenTest =
      "TEST-5075726861374018-110711-eb070b284902e84bbbee3f040abb897a-315664271";
  String? preferenceIDcreated;

  @override
  void initPage({PageArgs? arguments}) async {
    initPlatformState();
    preferenceIDcreated = await FlutterPayments.createPreferenceIdMercadoPago(
      accessToken: accessTokenTest,
      title: "Producto Test",
      quantity: 1,
      unitPrice: 3000.99,
      name: "John Doe",
      email: "jmamani@siltium.com",
    );
  }

  @override
  disposePage() {}

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    // try {
    //   platformVersion = await FlutterPayments.platformVersion;
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

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
    PaymentResultModel? paymentResultModel,
  }) async {
    if (paymentResultModel?.errorMessage != null) {
      //log("Pago Error: ${paymentResult.errorMessage}");
      await PageManager().openDefaultAlertPopup(
        title: title,
        description: "Pago error: ${paymentResultModel?.errorMessage}",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel?.result.toLowerCase() == "canceled") {
      //log("Pago Cancelado");
      await PageManager().openDefaultAlertPopup(
        title: title,
        description: "Pago cancelado",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel?.status == "rejected") {
      //log("Pago Rechazado");
      await PageManager().openDefaultAlertPopup(
        title: title,
        description: "Pago rechazado",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel?.status == "approved") {
      //log("Pago Aprobado");
      await PageManager().openDefaultAlertPopup(
        title: title,
        description: "Pago aprobado",
        labelAccept: "Ok",
      );
    } else if (paymentResultModel?.status == "in_process") {
      //log("Pago pendiente");
      await PageManager().openDefaultAlertPopup(
        title: title,
        description: "Pago pendiente",
        labelAccept: "Ok",
      );
    } else {
      // await PageManager().openDefaultAlertPopup(
      //   title: "",
      //   description: "",
      //   labelAccept: "",
      // );
    }
  }

  void payWithMercadoPagoAutomatic() async {
    PaymentResultModel? paymentResultModel =
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

    log("Obtuve resultado: $result");
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
        name: "John Doe",
        email: "jmamani@siltium.com",
        externalReference: "12345678",
      ),
      onResult: (String? result) {
        preferenceID = result;
      },
    ).show();

    log("preferenceID: $preferenceID");
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
          "Hash=035a22333034bef0853987ec9a3534d3868f9ead708c8f8163e1d49db0c0784a&Comercio=a6c51c8e-cfa3-4c0c-ba5e-0c0af4cbd284&SucursalComercio=aBethdMNgZ5Ev%2Bpcz58a6mI2e3wTIxg%2BipIf2faT3NQ%3D&TransaccionComercioId=transaction-dummy__2024-08-21_18-45-51&ClientData.NombreApellido=FirstName+LastName&CallbackSuccess=yGGyV1JW115EuIisAaRjdnqgbnlj0AMhZ8ziRkkwUJSnA%2FfAWVKCEGXKGJeBdYLN&CallbackCancel=Nv9P2KkfVjOmIa0KTzh4jlReBNEJnTqe1o11HVQ3hGykCl6LkSL4X9M%2FgxzCnstu&Monto=VP62MGbsHLO%2FtsXXiVFXLujoXGjqOnfAbgCYYZXsRD8%3D&Informacion=6q3Dmf747WS1U6y94UUz1MXetvdS8DDM3AnaRjPWkECcDHaT84PWZ5mYZaUEG2tu&ClientData.CUIT=11123456784&Producto%5B0%5D=Garrafa+15kg&MontoProducto%5B0%5D=30000",
    );

    _showResult(
      title: "Macro Click Web",
      paymentResultModel: paymentResultModel,
    );

    log("link: ${paymentResultModel.link}");
    log("download link: ${paymentResultModel.downloadLink}");
  }

  void payWithMacroClickWebPopup() async {
    PaymentResultModel paymentResultModel =
        await FlutterPayments.payWithMacroClickWebPopup(
      context: PageManager().navigatorKey.currentContext!,
      url: "https://sandboxpp.asjservicios.com.ar/",
      body:
          "Hash=035a22333034bef0853987ec9a3534d3868f9ead708c8f8163e1d49db0c0784a&Comercio=a6c51c8e-cfa3-4c0c-ba5e-0c0af4cbd284&SucursalComercio=vpCx3ui14OXAg%2F%2BQIJFMbKH%2BicWIv7uzgsMRZXnz7vg%3D&TransaccionComercioId=transaction-dummy__2024-08-20_16-24-03&ClientData.NombreApellido=FirstName+LastName&CallbackSuccess=UPIGbq8QvCFsqG0HkwgxSKPwgjzfWSVF66SGth5%2FWlOk4UWaFKcgNnJYLh4yp9hb&CallbackCancel=1Y3J9NJahYU1nm%2Fjf9Ik22saffgqjF1yFARdVRe5ZMXGuJmOXvAvGEp%2BfDyUg9%2Fi&Monto=9xYkrpkgNorlmG0WDGlAocAkndWtHe1YnN2JJK5BV5A%3D&Informacion=3m0AhC6njbmNmb0rGAKKc5Cbj3aIreu7nlPH%2FCIlrr7DxNw%2F4aPboED3EWI0uGsy&ClientData.CUIT=11123456784&Producto%5B0%5D=Garrafa+15kg&MontoProducto%5B0%5D=30000",
      isCancellable: true,
      enablePhysicalBackButton: false,
    );

    _showResult(
      title: "Macro Click Web",
      paymentResultModel: paymentResultModel,
    );
  }
}
