import 'dart:convert';

import "package:http/http.dart" as http;

import '../models/macro/macro_access_token.dart';
import '../models/macro/macro_client_credentials.dart';

class MacroCDPManager {
  static final MacroCDPManager _instance = MacroCDPManager._();
  bool sandboxEnvironment = true;

  factory MacroCDPManager() {
    return _instance;
  }

  MacroCDPManager._();

  setSandboxEnvironment(bool set) => sandboxEnvironment = set;

  Future<bool> checkAvailability() async {
    var response = await http.get(
      Uri.https(
        _getBaseURL(),
        "health",
      ),
    );

    return json.decode(response.body)["status"] ?? false;
  }

  Future<MacroClientCredentialsModel?> getAccessToken({
    required MacroClientCredentialsModel client,
  }) async {
    if (!(await checkAvailability())) {
      return null;
    }

    var response = await http.post(
      Uri.https(
        _getBaseURL(),
        "sesion",
      ),
      body: client.toJson(),
    );

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (!jsonResponse["status"]) return null;

    client.token = MacroAccessTokenModel.fromJson(json.decode(response.body));

    return client;
  }

  Future<Map<String, dynamic>?> getPaymentToken({
    String? branchOfficeClient,
    List<String>? products,
    double? totalPrice,
    String? commerceTransactionId,
    String? ip, //??????????????????????????????????????
    required MacroClientCredentialsModel client,
  }) async {
    if (!(await checkAvailability())) {
      return null;
    }

    var response = await http.post(
      Uri.https(_getBaseURL(), "tokens"),
      headers: {
        "Authorization": "Bearer ${client.token!.accessToken!}",
        "Content-Type": "application/json",
      },
      body: {
        "Comercio": client.guid,
        "SucursalComercio": branchOfficeClient,
        "Productos": products != null && products.isNotEmpty
            ? List<String>.from(products.map((x) => x))
            : null,
        "TransacicionComercioId": commerceTransactionId,
        "Ip": ip,
      },
    );

    return json.decode(response.body);
  }

  _getBaseURL() => sandboxEnvironment
      ? "https://sandboxpp.asjservicios.com.ar:8082/v1/"
      : "https://botonpp.asjservicios.com.ar:8082/v1/";
}
