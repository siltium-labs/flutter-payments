import 'package:multipay_plugin/src/utility/function_utils.dart';

import 'mercadopago_payment_method_security_code_model.dart';
import 'mercadopago_payment_method_card_number_model.dart';
import 'mercadopago_payment_method_bin_model.dart';

class MercadoPagoPaymentMethodSettingsModel {
  MercadoPagoPaymentMethodBinModel? bin;
  MercadoPagoPaymentMethodCardNumberModel? cardNumber;
  MercadoPagoPaymentMethodSecurityCodeModel? securityCode;

  MercadoPagoPaymentMethodSettingsModel(
      {this.bin, this.cardNumber, this.securityCode});

  MercadoPagoPaymentMethodSettingsModel.fromJson(Map<String, dynamic> json) {
    bin = classFromJson(json["bin"], MercadoPagoPaymentMethodBinModel.fromJson);
    cardNumber = classFromJson(
        json["card_number"], MercadoPagoPaymentMethodCardNumberModel.fromJson);
    securityCode = classFromJson(json["security_code"],
        MercadoPagoPaymentMethodSecurityCodeModel.fromJson);
  }

  Map<String, dynamic> toJson() => {
        "bin": classToJson(bin),
        "card_number": classToJson(cardNumber),
        "security_code": classToJson(securityCode),
      };
}
