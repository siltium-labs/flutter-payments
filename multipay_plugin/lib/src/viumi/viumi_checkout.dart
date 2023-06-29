import "dart:convert";
import "package:http/http.dart" as http;

import '../models/viumi/viumi_access_token_model.dart';
import '../models/viumi/viumi_client_credentials_model.dart';

class ViumiCheckoutManager {
  static final ViumiCheckoutManager _instance = ViumiCheckoutManager._();
  bool sandboxEnvironment = true;

  factory ViumiCheckoutManager() {
    return _instance;
  }

  ViumiCheckoutManager._();

  Future<ViumiClientCredentialsModel> postViumiClient(
      ViumiClientCredentialsModel client) async {
    var response = await http.post(
      Uri.https(
        "auth.geopagos.com",
        "/oauth/token",
      ),
      headers: {"Content-Type": "application/json"},
      body: client.toJson(),
    );

    client.accessToken = ViumiAccessTokenModel.fromJson(
      json.decode(
        response.body,
      ),
    );

    return client;
  }

  postGeneratePaymentIntent(
    ViumiClientCredentialsModel client,
    Map<String, dynamic> purchaseDetail,
  ) async {
    var response = await http.post(
      Uri.https(
        "https://api.viumi.com.ar",
        "/api/v2/orders",
      ),
      headers: {
        "Content-Type": "application/vnd.api+json",
        "Accept": "application/vnd.api+json",
        "Authorization": "Bearer ${client.accessToken!.accessToken!}",
      },
      body: purchaseDetail,
    );

    return json.decode(
      response.body,
    );
  }
}
