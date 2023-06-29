class MercadoPagoAddressModel {
  String? addressId;
  String? addressZipCode;
  String? addressStreetName;
  String? addressStreetNumber;

  MercadoPagoAddressModel(
      {this.addressId,
      this.addressStreetNumber,
      this.addressStreetName,
      this.addressZipCode});

  MercadoPagoAddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json["id"];
    addressZipCode = json["zip_code"];
    addressStreetName = json["street_name"];
    addressStreetNumber = json["street_number"];
  }

  Map<String, dynamic> toJson() => {
        "id": addressId,
        "zip_code": addressZipCode,
        "street_name": addressStreetName,
        "street_number": addressStreetNumber,
      };
}
