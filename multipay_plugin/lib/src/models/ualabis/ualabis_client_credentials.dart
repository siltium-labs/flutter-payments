import 'package:multipay_plugin/src/models/ualabis/ualabis_access_token.dart';

class UalaBisClientCredentialsModel {
  String? userName;
  String? clientId;
  String? clientSecret;
  String? grantType;
  UalaBisAccessTokenModel? accessToken;
  bool hasCustomButton = false;

  UalaBisClientCredentialsModel({
    this.userName,
    this.clientId,
    this.clientSecret,
    this.grantType,
    this.accessToken,
  });

  factory UalaBisClientCredentialsModel.fromJson(Map<String, dynamic> json) {
    return UalaBisClientCredentialsModel(
      userName: json["user_name"],
      clientId: json["client_id"],
      clientSecret: json["client_secret_id"],
      grantType: json["grant_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "client_id": clientId,
        "client_secret_id": clientSecret,
        "grant_type": grantType
      };
}
