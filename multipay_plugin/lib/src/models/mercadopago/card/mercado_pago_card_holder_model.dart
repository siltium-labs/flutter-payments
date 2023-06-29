import 'package:multipay_plugin/src/models/mercadopago/client/inner_models/mercadopago_identification_model.dart';
import 'package:multipay_plugin/src/utility/function_utils.dart';

class MercadoPagoCardHolderModel {
  String? name;
  MercadoPagoIdentificationModel? identification;

  MercadoPagoCardHolderModel({this.identification, this.name});

  MercadoPagoCardHolderModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    identification = classFromJson(
        json["identification"], MercadoPagoIdentificationModel.fromJson);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "identification": classToJson(identification),
      };
}
