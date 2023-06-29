class MercadoPagoIdentificationModel {
  String? identificationType;
  String? identificationNumber;

  MercadoPagoIdentificationModel({
    this.identificationNumber,
    this.identificationType,
  });

  MercadoPagoIdentificationModel.fromJson(Map<String, dynamic> json) {
    identificationType = json["type"];
    identificationNumber = json["number"];
  }

  Map<String, dynamic> toJson() => {
        "type": identificationType,
        "number": identificationNumber,
      };
}
