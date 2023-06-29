class MercadoPagoIdentificationTypeModel {
  String? id;
  String? name;
  String? type;
  int? minLength;
  int? maxLength;

  MercadoPagoIdentificationTypeModel(
      {this.id, this.maxLength, this.minLength, this.name, this.type});

  MercadoPagoIdentificationTypeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    type = json["type"];
    minLength = json["min_length"];
    maxLength = json["max_length"];
  }

  Map<String, dynamic> toJSon() => {
        "id": id,
        "name": name,
        "type": type,
        "min_length": minLength,
        "max_length": maxLength,
      };
}
