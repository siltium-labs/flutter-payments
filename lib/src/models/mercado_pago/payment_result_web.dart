// ignore_for_file: non_constant_identifier_names

class PaymentResultWeb {
  String? statusURL;
  String? collection_id;
  String? collection_status;
  String? payment_id;
  String? status;
  String? external_reference;
  String? payment_type;
  String? merchant_order_id;
  String? preference_id;
  String? site_id;
  String? processing_mode;
  String? merchant_account_id;

  PaymentResultWeb.fromJson(Map<String, dynamic> json) {
    statusURL = json["statusURL"];
    collection_id = json["collection_id"];
    collection_status = json["collection_status"];
    payment_id = json["payment_id"];
    status = json["status"];
    external_reference = json["external_reference"];
    payment_type = json["payment_type"];
    merchant_order_id = json["merchant_order_id"];
    preference_id = json["preference_id"];
    site_id = json["site_id"];
    processing_mode = json["processing_mode"];
    merchant_account_id = json["merchant_account_id"];
  }
}
