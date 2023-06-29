class MercadoPagoPaymentMethodModel {
  String? id;
  String? name;
  String? paymentTypeId;
  String? thumbnail;
  String? secureThumbnail;

  MercadoPagoPaymentMethodModel({
    this.id,
    this.name,
    this.paymentTypeId,
    this.secureThumbnail,
    this.thumbnail,
  });

  MercadoPagoPaymentMethodModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    paymentTypeId = json["payment_type_id"];
    thumbnail = json["thumbnail"];
    secureThumbnail = json["secure_thumbnail"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "payment_type_id": paymentTypeId,
        "thumbnail": thumbnail,
        "secure_thumbnail": secureThumbnail,
      };
}
