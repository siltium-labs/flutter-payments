class MercadoPagoPhoneModel {
  String? phoneAreaCode;
  String? phoneNumber;

  MercadoPagoPhoneModel({
    this.phoneAreaCode,
    this.phoneNumber,
  });

  MercadoPagoPhoneModel.fromJson(Map<String, dynamic> json) {
    phoneAreaCode = json["area_code"];
    phoneNumber = json["number"];
  }

  Map<String, dynamic> toJson() => {
        "area_code": phoneAreaCode,
        "number": phoneNumber,
      };
}
