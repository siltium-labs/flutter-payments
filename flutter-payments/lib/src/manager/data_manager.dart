import 'dart:convert';
import 'package:http/http.dart' as http;

class DataManager {
  static Future<String> getTokenCardMercadoPago({
    required String accessToken,
    String documentType = "DNI",
    required String documentNumber,
    required String cardNumber,
    required String cardHolder,
    required String expirationMonth,
    required String expirationYear,
    required String cvv,
  }) async {
    String body = json.encode(
      {
        "card_number": cardNumber,
        "security_code": cvv,
        "expiration_month": expirationMonth,
        "expiration_year": expirationYear,
        "cardholder": {
          "identification": {
            "type": documentType,
            "number": documentNumber,
          },
          "name": cardHolder,
        },
      },
    );
    final response = await http.post(
      Uri.parse('https://api.mercadopago.com/v1/card_tokens'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody["id"];
    } else {
      throw Exception('Error tokenizing card');
    }
  }
}
