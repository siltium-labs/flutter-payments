import 'package:multipay_plugin/src/utility/function_utils.dart';

import 'inner_models/mercadopago_payment_method_financial_institutions_model.dart';
import 'inner_models/mercadopago_payment_method_settings_model.dart';

class MercadoPagoPaymentMethodModel {
  String? id;
  String? name;
  String? paymentTypeId;
  String? status;
  String? thumbnail;
  String? secureThumbnail;
  String? deferredCapture;
  List<MercadoPagoPaymentMethodSettingsModel?>? settings;
  List<dynamic>? additionalInfoNeeded;
  int? minAllowedAmount;
  int? maxAllowedAmount;
  int? accreditationTime;
  List<MercadoPagoPaymentMethodFinancialInstitutionsModel?>?
      financialInstitutions;
  List<dynamic>? processingModes;

  MercadoPagoPaymentMethodModel({
    this.accreditationTime,
    this.additionalInfoNeeded,
    this.deferredCapture,
    this.financialInstitutions,
    this.id,
    this.maxAllowedAmount,
    this.minAllowedAmount,
    this.name,
    this.paymentTypeId,
    this.processingModes,
    this.settings,
    this.status,
    this.thumbnail,
    this.secureThumbnail,
  });

  MercadoPagoPaymentMethodModel.fromJson(Map<String, dynamic> json) {
    accreditationTime = json["accreditation_time"];
    additionalInfoNeeded = json["additional_info_needed"];
    deferredCapture = json["deferred_capture"];
    financialInstitutions = json["financial_institutions"] != null
        ? List<MercadoPagoPaymentMethodFinancialInstitutionsModel>.from(
            json["financial_institutions"].map(
              (x) => classFromJson(
                x,
                MercadoPagoPaymentMethodFinancialInstitutionsModel.fromJson,
              ),
            ),
          )
        : null;
    id = json["id"];
    maxAllowedAmount = json["max_allowed_amount"];
    minAllowedAmount = json["min_allowed_amount"];
    name = json["name"];
    paymentTypeId = json["payment_type_id"];
    processingModes = json["processing_modes"];
    settings = json["settings"] != null
        ? List<MercadoPagoPaymentMethodSettingsModel>.from(
            json["settings"].map(
              (x) => classFromJson(
                x,
                MercadoPagoPaymentMethodSettingsModel.fromJson,
              ),
            ),
          )
        : null;
    status = json["status"];
    thumbnail = json["thumbnail"];
    secureThumbnail = json["secure_thumbnail"];
  }

  Map<String, dynamic> toJson() => {
        "accreditation_time": accreditationTime,
        "additional_info_needed": additionalInfoNeeded,
        "deferred_capture": deferredCapture,
        "financial_institutions":
            financialInstitutions != null && financialInstitutions!.isNotEmpty
                ? financialInstitutions!.map((x) => x!.toJson()).toList()
                : null,
        "id": id,
        "max_allowed_amount": maxAllowedAmount,
        "min_allowed_amount": minAllowedAmount,
        "name": name,
        "payment_type_id": paymentTypeId,
        "processing_modes": processingModes,
        "settings": settings != null && settings!.isNotEmpty
            ? settings!.map((x) => x!.toJson()).toList()
            : null,
        "status": status,
        "thumbnail": thumbnail,
        "secure_thumbnail": secureThumbnail,
      };
}
