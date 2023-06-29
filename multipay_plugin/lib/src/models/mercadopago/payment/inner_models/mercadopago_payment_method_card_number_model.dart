class MercadoPagoPaymentMethodCardNumberModel {
  int? length;
  String? validation;

  MercadoPagoPaymentMethodCardNumberModel({this.length, this.validation});

  MercadoPagoPaymentMethodCardNumberModel.fromJson(Map<String, dynamic> json) {
    length = json["length"];
    validation = json["validation"];
  }

  Map<String, dynamic> toJson() => {
        "length": length,
        "validation": validation,
      };
}
