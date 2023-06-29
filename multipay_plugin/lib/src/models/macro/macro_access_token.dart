class MacroAccessTokenModel {
  String? accessToken;
  String? secretKey;

  MacroAccessTokenModel({
    this.accessToken,
    this.secretKey,
  });

  factory MacroAccessTokenModel.fromJson(Map<String, dynamic> json) {
    return MacroAccessTokenModel(
      accessToken: json["data"],
      secretKey: json["secretKey"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": accessToken,
        "secretKey": secretKey,
      };
}
