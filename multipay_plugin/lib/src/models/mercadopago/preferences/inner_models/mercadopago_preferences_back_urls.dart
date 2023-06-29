class MercadoPagoPreferencesBackUrls{
  String? success;
  String? pending;
  String? failure;

  MercadoPagoPreferencesBackUrls({
    this.failure,
    this.pending,
    this.success,
  });

  MercadoPagoPreferencesBackUrls.fromJson(Map<String, dynamic> json){
    success = json["success"];
    pending = json["pending"];
    failure = json["failure"];
  }

  toJson() => {
    "success": success,
    "pending": pending,
    "failure": failure,
  };
}