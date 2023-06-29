class ViumiAccessTokenModel {
  String? tokenType;
  int? expiresIn;
  String? accessToken;
  String? refreshToken;

  ViumiAccessTokenModel({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
  });

  factory ViumiAccessTokenModel.fromJson(Map<String, dynamic> json) {
    return ViumiAccessTokenModel(
      tokenType: json["token_type"],
      expiresIn: int.tryParse(json["expires_in"]),
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"] ?? "*",
    );
  }

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "expires_in": expiresIn,
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
