import '../../../../utility/function_utils.dart';
import '../../client/inner_models/mercadopago_address_model.dart';
import '../../client/inner_models/mercadopago_identification_model.dart';
import '../../client/inner_models/mercadopago_phone_model.dart';

class MercadoPagoPreferencesPayerModel {
  String? name;
  String? surname;
  String? email;
  DateTime? dateCreated;
  MercadoPagoPhoneModel? phone;
  MercadoPagoIdentificationModel? identification;
  MercadoPagoAddressModel? address;

  MercadoPagoPreferencesPayerModel({
    this.address,
    this.dateCreated,
    this.email,
    this.identification,
    this.name,
    this.phone,
    this.surname,
  });

  MercadoPagoPreferencesPayerModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    surname = json["surname"];
    email = json["email"];
    dateCreated = json["date_created"] != null
        ? DateTime.parse(json["date_created"])
        : null;
    phone = classFromJson(json["phone"], MercadoPagoPhoneModel.fromJson);
    identification = classFromJson(
        json["identification"], MercadoPagoIdentificationModel.fromJson);
    address = classFromJson(json["address"], MercadoPagoAddressModel.fromJson);
  }

  toJson() => {
        "name": name,
        "surname": surname,
        "phone": classToJson(phone),
        "identification": classToJson(identification),
        "address": classToJson(address),
      };
}
