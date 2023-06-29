class MercadoPagoItemModel {
  String? id;
  String? title;
  String? description;
  String? pictureUrl;
  String? categoryId;
  String? currencyId;
  num? quantity;
  num? unitPrice;

  MercadoPagoItemModel({
    this.categoryId,
    this.description,
    this.id,
    this.pictureUrl,
    this.quantity,
    this.title,
    this.unitPrice,
    this.currencyId,
  });

  MercadoPagoItemModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    pictureUrl = json["picture_url"];
    categoryId = json["category_id"];
    quantity = json["quantity"];
    unitPrice = json["unit_price"];
    currencyId = json["currency_id"];
  }

  toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "picture_url": pictureUrl,
        "category_id": categoryId,
        "quantity": quantity,
        "unit_price": unitPrice,
        "currency_id": currencyId,
      };
}
