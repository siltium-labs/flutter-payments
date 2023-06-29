class MercadoPagoCityModel {
  String? id;
  String? name;

  MercadoPagoCityModel({
    this.id,
    this.name,
  });

  MercadoPagoCityModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
