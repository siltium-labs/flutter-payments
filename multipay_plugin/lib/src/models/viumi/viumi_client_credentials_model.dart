import 'package:multipay_plugin/src/models/viumi/viumi_access_token_model.dart';

class ViumiClientCredentialsModel {
  String? grantType;
  String? clientId;
  String? clientSecret;
  String? scope = "*";
  ViumiAccessTokenModel? accessToken;

  ViumiClientCredentialsModel({
    this.grantType,
    this.clientId,
    this.clientSecret,
    this.scope,
    this.accessToken,
  });

  factory ViumiClientCredentialsModel.fromJson(Map<String, dynamic> json) {
    return ViumiClientCredentialsModel(
      grantType: json["grant_type"],
      clientId: json["client_id"],
      clientSecret: json["client_secret"],
      scope: json["scope"] ?? "*",
    );
  }

  Map<String, dynamic> toJson() => {
        "grant_type": grantType,
        "client_id": clientId,
        "client_secret": clientSecret,
        "scope": scope
      };
}
