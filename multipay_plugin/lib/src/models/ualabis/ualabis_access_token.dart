class UalaBisAccessTokenModel {
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  UalaBisAccessTokenModel({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  factory UalaBisAccessTokenModel.fromJson(Map<String, dynamic> json) {
    return UalaBisAccessTokenModel(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      expiresIn: json["expires_in"],
    );
  }

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}
