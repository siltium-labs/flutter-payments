class MercadoPagoPaymentMethodFinancialInstitutionsModel {
  num? id;
  String? description;

  MercadoPagoPaymentMethodFinancialInstitutionsModel(
      {this.description, this.id});

  MercadoPagoPaymentMethodFinancialInstitutionsModel.fromJson(
      Map<String, dynamic> json) {
    id = json["id"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}
