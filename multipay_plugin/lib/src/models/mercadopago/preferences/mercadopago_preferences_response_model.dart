import '../../../utility/function_utils.dart';
import '../client/inner_models/mercadopago_addresses_model.dart';
import '../items/mercadopago_item_model.dart';
import '../payment/inner_models/mercadopago_payer_model.dart';
import 'inner_models/mercadopago_preferences_back_urls.dart';
import 'inner_models/mercadopago_preferences_payment_methods_model.dart';

class MercadoPagoPreferencesResponseModel {
  num? collectorId;
  String? operationType;
  List<MercadoPagoItemModel>? items;
  MercadoPagoPayerModel? payer;
  MercadoPagoPreferencesBackUrls? backUrls;
  String? autoReturn;
  MercadoPagoPreferencesPaymentMethodsModel? paymentMethods;
  String? clientId;
  String? marketplace;
  num? marketplaceFee;
  MercadoPagoAddressesModel? shipments;
  String? notificationUrl;
  String? statementDescriptor;
  String? externalReference;
  String? additionalInfo;
  bool? expires;
  DateTime? expirationDateFrom;
  DateTime? expirationDateTo;
  DateTime? dateCreated;
  String? id;
  String? initPoint;
  String? sandboxInitPoint;
  Map<String, dynamic>? metadata;

  MercadoPagoPreferencesResponseModel({
    this.additionalInfo,
    this.autoReturn,
    this.backUrls,
    this.clientId,
    this.collectorId,
    this.dateCreated,
    this.expirationDateFrom,
    this.expirationDateTo,
    this.expires,
    this.externalReference,
    this.id,
    this.initPoint,
    this.items,
    this.marketplace,
    this.marketplaceFee,
    this.metadata,
    this.notificationUrl,
    this.operationType,
    this.payer,
    this.paymentMethods,
    this.sandboxInitPoint,
    this.shipments,
    this.statementDescriptor,
  });

  MercadoPagoPreferencesResponseModel.fromJson(Map<String, dynamic> json) {
    collectorId = json["collector_id"];
    operationType = json["opperation_type"];
    items = json["items"] != null
        ? List<MercadoPagoItemModel>.from(json["items"]
            .map((x) => classFromJson(x, MercadoPagoItemModel.fromJson)))
        : null;
    payer = classFromJson(json["payer"], MercadoPagoPayerModel.fromJson);
    backUrls = classFromJson(
        json["back_urls"], MercadoPagoPreferencesBackUrls.fromJson);
    autoReturn = json["auto_return"];
    paymentMethods = classFromJson(json["payment_methods"],
        MercadoPagoPreferencesPaymentMethodsModel.fromJson);
    clientId = json["client_id"];
    marketplace = json["marketplace"];
    marketplaceFee = json["marketplace_fee"];
    shipments =
        classFromJson(json["shipments"], MercadoPagoAddressesModel.fromJson);
    notificationUrl = json["notification_url"];
    statementDescriptor = json["statement_descriptor"];
    externalReference = json["external_reference"];
    additionalInfo = json["additional_info"];
    expires = json["expires"];
    expirationDateFrom = json["expiration_date_from"] != null
        ? DateTime.parse(json["expiration_date_from"])
        : null;
    expirationDateTo = json["expiration_date_to"] != null
        ? DateTime.parse(json["expiration_date_to"])
        : null;
    dateCreated = json["date_created"] != null
        ? DateTime.parse(json["date_created"])
        : null;
    id = json["id"];
    initPoint = json["init_point"];
    sandboxInitPoint = json["sandbox_init_point"];
    metadata = json["metadata"];
  }

  toJson() => {
        "collector_id": collectorId,
        "opperation_type": operationType,
        "items": items != null && items!.isNotEmpty
            ? items!.map((x) => x.toJson()).toList()
            : null,
        "payer": classToJson(payer),
        "back_urls": classToJson(backUrls),
        "auto_return": autoReturn,
        "payment_methods": classToJson(paymentMethods),
        "client_id": clientId,
        "marketplace": marketplace,
        "marketplace_fee": marketplaceFee,
        "shipments": classToJson(shipments),
        "notification_url": notificationUrl,
        "statement_descriptor": statementDescriptor,
        "external_reference": externalReference,
        "additional_info": additionalInfo,
        "expires": expires,
        "expiration_date_from": expirationDateFrom.toString(),
        "expiration_date_to": expirationDateTo.toString(),
        "date_created": dateCreated.toString(),
        "id": id,
        "init_point": initPoint,
        "sandbox_init_point": sandboxInitPoint,
        "metadata": metadata,
      };
}
