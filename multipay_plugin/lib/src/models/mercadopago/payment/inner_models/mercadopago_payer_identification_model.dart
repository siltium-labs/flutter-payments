class MercadoPagoPayerIdentificationModel {
  String? type;
  String? number;

  MercadoPagoPayerIdentificationModel({
    this.number,
    this.type,
  });

  MercadoPagoPayerIdentificationModel.fromJson(Map<String, dynamic> json){
    type = json["type"];
    number = json["number"];
  }

  toJson() => {
    "type": type,
    "number": number,
  };
}
