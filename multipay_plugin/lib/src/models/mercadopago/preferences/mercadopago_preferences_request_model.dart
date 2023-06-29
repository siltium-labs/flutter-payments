import '../../../utility/function_utils.dart';
import '../client/inner_models/mercadopago_addresses_model.dart';
import '../items/mercadopago_item_model.dart';
import 'inner_models/mercadopago_preferences_back_urls.dart';
import 'inner_models/mercadopago_preferences_differential_pricing_model.dart';
import 'inner_models/mercadopago_preferences_payer_model.dart';
import 'inner_models/mercadopago_preferences_payment_methods_model.dart';
import 'inner_models/mercadopago_preferences_track_model.dart';

class MercadoPagoPreferencesRequestModel {
  String? additionalInfo;
  String? autoReturn;
  MercadoPagoPreferencesBackUrls? backUrls;
  DateTime? dateOfExpiration;
  MercadoPagoPreferencesDifferentialPricingModel? differentialPricing;
  DateTime? expirationDateFrom;
  DateTime? expirationDateTo;
  bool? expires;
  String? externalReference;
  List<MercadoPagoItemModel>? items;
  String? marketplace;
  num? marketplaceFee;
  Map<String, dynamic>? metadata;
  String? notificationUrl;
  MercadoPagoPreferencesPayerModel? payer;
  MercadoPagoPreferencesPaymentMethodsModel? paymentMethods;
  MercadoPagoAddressesModel? shipments;
  String? statementDescriptor;
  List<MercadoPagoPreferencesTrackModel>? tracks;

  MercadoPagoPreferencesRequestModel({
    this.additionalInfo,
    this.autoReturn,
    this.backUrls,
    this.dateOfExpiration,
    this.differentialPricing,
    this.expirationDateFrom,
    this.expirationDateTo,
    this.expires,
    this.externalReference,
    this.items,
    this.marketplace,
    this.marketplaceFee,
    this.metadata,
    this.notificationUrl,
    this.payer,
    this.paymentMethods,
    this.shipments,
    this.statementDescriptor,
    this.tracks,
  });

  MercadoPagoPreferencesRequestModel.fromJson(Map<String, dynamic> json) {
    additionalInfo = json["additional_info"];
    autoReturn = json["auto_return"];
    backUrls = classFromJson(
        json["back_urls"], MercadoPagoPreferencesBackUrls.fromJson);
    dateOfExpiration = json["date_of_expiration"] != null
        ? DateTime.parse(json["date_of_expiration"])
        : null;
    differentialPricing = classFromJson(json["differential_pricing"],
        MercadoPagoPreferencesDifferentialPricingModel.fromJson);
    expirationDateFrom = json["expiration_date_from"] != null
        ? DateTime.parse(json["expiration_date_from"])
        : null;
    expirationDateTo = json["expiration_date_to"] != null
        ? DateTime.parse(json["expiration_date_to"])
        : null;
    expires = json["expires"];
    items = json["items"] != null
        ? List<MercadoPagoItemModel>.from(json["items"]
            .map((x) => classFromJson(x, MercadoPagoItemModel.fromJson)))
        : null;
    marketplace = json["marketplace"];
    marketplaceFee = json["marketplace_fee"];
    metadata = json["metadata"];
    notificationUrl = json["notification_url"];
    payer =
        classFromJson(json["payer"], MercadoPagoPreferencesPayerModel.fromJson);
    paymentMethods = classFromJson(json["payment_metods"],
        MercadoPagoPreferencesPaymentMethodsModel.fromJson);
    shipments =
        classFromJson(json["shipments"], MercadoPagoAddressesModel.fromJson);
    statementDescriptor = json["statement_descriptor"];
    tracks = json["tracks"] != null
        ? List<MercadoPagoPreferencesTrackModel>.from(json["tracks"].map(
            (x) => classFromJson(x, MercadoPagoPreferencesTrackModel.fromJson)))
        : null;
  }

  toJson() => {
        "additional_info": additionalInfo,
        "auto_return": autoReturn,
        "back_urls": classToJson(backUrls),
        "differential_pricing": classToJson(differentialPricing),
        "expires": expires,
        "external_reference": externalReference,
        "items": items != null && items!.isNotEmpty
            ? items!.map((x) => x.toJson()).toList()
            : null,
        "marketplace": marketplace,
        "marketplace_fee": marketplaceFee,
        "metadata": metadata,
        "notification_url": notificationUrl,
        "payer": classToJson(payer),
        "payment_methods": classToJson(paymentMethods),
        "shipments": classToJson(shipments),
        "statement_descriptor": statementDescriptor,
        "tracks": tracks != null && tracks!.isNotEmpty
            ? tracks!.map((x) => x.toJson()).toList()
            : null,
      };
}
