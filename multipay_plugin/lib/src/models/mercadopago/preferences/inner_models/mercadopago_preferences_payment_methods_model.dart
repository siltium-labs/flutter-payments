class MercadoPagoPreferencesPaymentMethodsModel{
  List<String>? excludedPaymentMethods;
  List<String>? excludedPaymentTypes;
  String? installments;
  String? defaultPaymentMethodId;
  String? defaultInstallments;

  MercadoPagoPreferencesPaymentMethodsModel({
    this.defaultInstallments,
    this.defaultPaymentMethodId,
    this.excludedPaymentMethods,
    this.excludedPaymentTypes,
    this.installments,
  });

  MercadoPagoPreferencesPaymentMethodsModel.fromJson(Map<String, dynamic> json){
    excludedPaymentMethods = json["excluded_payment_methods"] != null ? List<String>.from(
            json["excluded_payment_methods"].map((x) => x["id"])) : null;
    excludedPaymentTypes = json["excluded_payment_types"] != null ? List<String>.from(
            json["excluded_payment_types"].map((x) => x["id"])) : null;
    installments = json["installments"];
    defaultPaymentMethodId = json["default_payment_method_id"];
    defaultInstallments = json["default_installments"];
  }

  toJson() => {
    "excluded_payment_methods": excludedPaymentMethods != null ? excludedPaymentMethods!.map((x) => x).toList()
            : null,
    "excluded_payment_types": excludedPaymentTypes != null ? excludedPaymentTypes!.map((x) => x).toList()
            : null,
    "installments": installments,
    "default_payment_method_id": defaultPaymentMethodId,
    "default_installments": defaultInstallments,
  };
}