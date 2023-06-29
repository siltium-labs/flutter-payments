class MercadoPagoPreferencesDifferentialPricingModel {
  num? id;

  MercadoPagoPreferencesDifferentialPricingModel({this.id});

  MercadoPagoPreferencesDifferentialPricingModel.fromJson(
      Map<String, dynamic> json) {
    id = json["id"];
  }

  toJson() => {
        "id": id,
      };
}
