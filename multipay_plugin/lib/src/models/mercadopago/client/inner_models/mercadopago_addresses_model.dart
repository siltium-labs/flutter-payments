import 'mercadopago_city_model.dart';

class MercadoPagoAddressesModel {
  String? id;
  String? phone;
  String? name;
  String? floor;
  String? apartment;
  String? streetName;
  int? streetNumber;
  String? zipCode;
  MercadoPagoCityModel? city;
  MercadoPagoCityModel? state;
  MercadoPagoCityModel? country;
  MercadoPagoCityModel? neighborhood;
  MercadoPagoCityModel? municipality;
  String? comments;
  DateTime? dateCreated;

  MercadoPagoAddressesModel({
    this.apartment,
    this.city,
    this.comments,
    this.country,
    this.dateCreated,
    this.floor,
    this.id,
    this.municipality,
    this.name,
    this.neighborhood,
    this.phone,
    this.state,
    this.streetName,
    this.streetNumber,
    this.zipCode,
  });

  MercadoPagoAddressesModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    phone = json["phone"];
    name = json["name"];
    floor = json["floor"];
    apartment = json["apartment"];
    streetName = json["street_name"];
    streetNumber = json["street_number"];
    zipCode = json["zip_code"];
    city = json["city"] != null
        ? MercadoPagoCityModel.fromJson(json["city"])
        : null;
    state = json["state"] != null
        ? MercadoPagoCityModel.fromJson(json["state"])
        : null;
    country = json["country"] != null
        ? MercadoPagoCityModel.fromJson(json["country"])
        : null;
    neighborhood = json["neighborhood"] != null
        ? MercadoPagoCityModel.fromJson(json["neighborhood"])
        : null;
    municipality = json["municipality"] != null
        ? MercadoPagoCityModel.fromJson(json["municipality"])
        : null;
    comments = json["comments"];
    dateCreated = json["date_created"] != null
        ? DateTime.parse(json['date_created']).toLocal()
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "name": name,
        "floor": floor,
        "apartment": apartment,
        "street_name": streetName,
        "street_number": streetNumber,
        "zip_code": zipCode,
        "city": city != null ? city!.toJson() : null,
        "state": state != null ? state!.toJson() : null,
        "country": country != null ? country!.toJson() : null,
        "neighborhood": neighborhood != null ? neighborhood!.toJson() : null,
        "municipality": municipality != null ? municipality!.toJson() : null,
        "comments": comments,
        "date_created": dateCreated.toString(),
      };
}
