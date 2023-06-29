import 'package:multipay_plugin/src/models/mercadopago/card/mercado_pago_card_holder_model.dart';

import '../../../utility/function_utils.dart';

class MercadoPagoCardModel {
  String? securityCode;
  String? expirationYear;
  String? expirationMonth;
  String? cardNumber;
  MercadoPagoCardHolderModel? cardHolder;

  MercadoPagoCardModel({
    this.cardHolder,
    this.cardNumber,
    this.expirationMonth,
    this.expirationYear,
    this.securityCode,
  });

  MercadoPagoCardModel.fromJson(Map<String, dynamic> json) {
    securityCode = json["security_code"];
    expirationYear = json["expiration_year"];
    expirationMonth = json["expiration_month"];
    cardNumber = json["card_number"];
    cardHolder =
        classFromJson(json["cardholder"], MercadoPagoCardHolderModel.fromJson);
  }

  Map<String, dynamic> toJson() => {
        "security_code": securityCode,
        "expiration_year": expirationYear,
        "expiration_month": expirationMonth,
        "card_number": cardNumber,
        "cardholder": classToJson(cardHolder),
      };
}
