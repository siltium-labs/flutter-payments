class MercadoPagoPreferencesTrackModel {
  String? type;
  String? values;

  MercadoPagoPreferencesTrackModel({this.type, this.values});

  MercadoPagoPreferencesTrackModel.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    values = json["values"];
  }

  toJson() => {
        "type": type,
        "values": values,
      };
}
