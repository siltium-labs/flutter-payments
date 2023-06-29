import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:multipay_plugin/src/models/mercadopago/payment/mercadopago_payment_method_model.dart';
import '../models/mercadopago/card/mercado_pago_card_model.dart';
import '../models/mercadopago/client/mercadopago_client_credentials.dart';
import '../models/mercadopago/client/mercadopago_identification_type_model.dart';
import '../models/mercadopago/preferences/mercadopago_preferences_request_model.dart';
import '../models/mercadopago/preferences/mercadopago_preferences_response_model.dart';

class MercadoPagoManager {
  static final MercadoPagoManager _instance = MercadoPagoManager._();

  factory MercadoPagoManager() {
    return _instance;
  }

  MercadoPagoManager._();

  Future<MercadoPagoPreferencesResponseModel?> getPurchasePreferenceId(
    MercadoPagoPreferencesRequestModel request,
    MercadoPagoClientCredentials credentials,
  ) async {
    var response = await http.post(
      Uri.https(
        "api.mercadopago.com",
        "checkout/preferences",
      ),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": credentials.bearerToken!,
      },
      body: jsonEncode(request.toJson()),
    );

    return MercadoPagoPreferencesResponseModel.fromJson(
        jsonDecode(response.body));
  }

  Future<MercadoPagoPreferencesResponseModel?> getPurchaseFromPreference(
      String mercadoPagoPreferenceId,
      MercadoPagoClientCredentials credentials) async {
    var response = await http.post(
      Uri.https(
        "api.mercadopago.com",
        "checkout/preferences/$mercadoPagoPreferenceId",
      ),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": credentials.bearerToken!,
      },
    );

    return MercadoPagoPreferencesResponseModel.fromJson(
        jsonDecode(response.body));
  }

  Future<String?> generateCardToken(
    String publicKey,
    MercadoPagoCardModel card,
    String paymentMethod,
  ) async {
    const platform = MethodChannel("multipay_plugin");
    try {
      String? result = await (platform.invokeMethod<String>(
        "mpGetCardID",
        {
          "publicKey": publicKey,
          "cardNumber": card.cardNumber,
          "expirationMonth": card.expirationMonth,
          "expirationYear": card.expirationYear,
          "securityCode": card.securityCode,
          "cardHolderName": card.cardHolder!.name,
          "identificationType":
              card.cardHolder!.identification!.identificationType,
          "identificationNumber":
              card.cardHolder!.identification!.identificationNumber,
        },
      ));
      print(result);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<String?> validateCardNumber(
    String cardNumber,
    MercadoPagoPaymentMethodModel paymentMethod,
  ) async {
    const platform = MethodChannel("multipay_plugin");
    try {
      String? result = await (platform.invokeMethod<String>(
        "mpValidateCardNumber",
        {
          "cardNumber": "451764607066",
          "expirationMonth": 07,
          "expirationYear": 25,
          "securityCode": "375",
          "cardHolderName": "LIGOULE MARCOS",
          "identificationType": "DNI",
          "identificationNumber": "40709896",
          "paymentMethod": paymentMethod.toJson(),
        },
      ));
      print(result);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<List<MercadoPagoPaymentMethodModel>?> getMPPaymentMethods(
      MercadoPagoClientCredentials credentials) async {
    var response = await http.get(
      Uri.https(
        "api.mercadopago.com",
        "v1/payment_methods",
      ),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": credentials.bearerToken!,
      },
    );

    return List<MercadoPagoPaymentMethodModel>.from(
      jsonDecode(response.body).map(
        (x) => MercadoPagoPaymentMethodModel.fromJson(
          x,
        ),
      ),
    );
  }

  Future<List<MercadoPagoIdentificationTypeModel>?> getMPIdTypes(
      MercadoPagoClientCredentials credentials) async {
    var response = await http.get(
      Uri.https(
        "api.mercadopago.com",
        "v1/identification_types",
      ),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": credentials.bearerToken!,
      },
    );

    return List<MercadoPagoIdentificationTypeModel>.from(
      jsonDecode(response.body).map(
        (x) => MercadoPagoIdentificationTypeModel.fromJson(
          x,
        ),
      ),
    );
  }
}
