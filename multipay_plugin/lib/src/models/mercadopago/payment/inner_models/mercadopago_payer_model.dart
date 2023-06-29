import '../../../../utility/function_utils.dart';
import 'mercadopago_payer_identification_model.dart';

class MercadoPagoPayerModel {
  String? entityType;
  String? type;
  String? id;
  String? email;
  MercadoPagoPayerIdentificationModel? identification;
  String? firstName;
  String? lastName;
  String? paymentMethodId;
  String? statementDescriptor;
  String? token;
  num? transactionAmount;

  MercadoPagoPayerModel({
    this.email,
    this.entityType,
    this.firstName,
    this.id,
    this.identification,
    this.lastName,
    this.paymentMethodId,
    this.statementDescriptor,
    this.token,
    this.transactionAmount,
    this.type,
  });

  MercadoPagoPayerModel.fromJson(Map<String, dynamic> json) {
    entityType = json["entity_type"];
    type = json["type"];
    id = json["id"];
    email = json["email"];
    identification = classFromJson(
        json["identification"], MercadoPagoPayerIdentificationModel.fromJson);
    firstName = json["first_name"];
    lastName = json["last_name"];
    paymentMethodId = json["payment_method_id"];
    statementDescriptor = json["statement_descriptor"];
    token = json["token"];
    transactionAmount = json["transaction_amount"];
  }

  toJson() => {
        "entity_type": entityType,
        "type": type,
        "id": id,
        "email": email,
        "identification": classToJson(identification),
        "first_name": firstName,
        "last_name": lastName,
        "payment_method_id": paymentMethodId,
        "statement_descriptor": statementDescriptor,
        "token": token,
        "transaction_amount": transactionAmount,
      };
}
