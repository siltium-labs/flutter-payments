class MercadoPagoPaymentMethodSecurityCodeModel {
  String? mode;
  int? length;
  String? cardLocation;

  MercadoPagoPaymentMethodSecurityCodeModel(
      {this.cardLocation, this.length, this.mode});

  MercadoPagoPaymentMethodSecurityCodeModel.fromJson(
      Map<String, dynamic> json) {
    mode = json["mode"];
    length = json["length"];
    cardLocation = json["card_location"];
  }

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "length": length,
        "card_location": cardLocation,
      };
}
