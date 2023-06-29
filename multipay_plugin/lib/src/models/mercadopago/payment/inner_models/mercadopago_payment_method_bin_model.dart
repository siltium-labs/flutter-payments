class MercadoPagoPaymentMethodBinModel {
  String? pattern;
  String? exclusionPattern;
  String? installmentsPattern;

  MercadoPagoPaymentMethodBinModel({
    this.exclusionPattern,
    this.installmentsPattern,
    this.pattern,
  });

  MercadoPagoPaymentMethodBinModel.fromJson(Map<String, dynamic> json) {
    pattern = json["pattern"];
    exclusionPattern = json["exclusion_pattern"];
    installmentsPattern = json["installments_pattern"];
  }

  Map<String, dynamic> toJson() => {
        "pattern": pattern,
        "exclusion_pattern": exclusionPattern,
        "installments_pattern": installmentsPattern,
      };
}
