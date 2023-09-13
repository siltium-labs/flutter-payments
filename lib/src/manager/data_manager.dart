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

  static Future<Map<String, dynamic>?> createCardPayment({
    required String accessToken,
    required String tokenCard,
    //body
    required double transactionAmount,
    //required String token,
    required int installments,
    required String firstName,
    required String lastName,
    required String email,
    required String type,
    required String identificationType,
    required String identificationNumber,
    required String zipCode,
    required String streetName,
    required String streetNumber,
    required String neighborhood,
    required String city,
    required String federalUnit,
    required String description,
  }) async {
    String body = json.encode(
      {
        "transaction_amount": transactionAmount,
        "token": tokenCard,
        "installments": installments,
        "payer": {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "type": type,
          "identification": {
            "type": identificationType,
            "number": identificationNumber
          },
          "address": {
            "zip_code": zipCode,
            "street_name": streetName,
            "street_number": streetNumber,
            "neighborhood": neighborhood,
            "city": city,
            "federal_unit": federalUnit
          }
        },
        "description": description
      },
    );
    final response = await http.post(
      Uri.parse('https://api.mercadopago.com/v1/payments'),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json"
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody;
    } else {
      return null;
    }
  }

  static Future<String?> createPreferenceIdMercadoPago({
    required String accessToken,
    //body
    required String title,
    required int quantity,
    String currencyId = "ARG",
    required double unitPrice,
    required String name,
    required String email,
  }) async {
    String body = json.encode(
      {
        "items": [
          {
            "title": title,
            "quantity": quantity,
            "currency_id": currencyId,
            "unit_price": unitPrice,
          }
        ],
        "payer": {
          "name": name,
          "email": email,
        },
        "payment_methods": {
          "exclude_payment_types": [
            //Tarjeta de crédito: "credit_card"
            //Tarjeta de débito: "debit_card"
            //Efectivo (pago en puntos de pago, como tiendas locales): "ticket"
            //Transferencia bancaria: "bank_transfer"

            {
              "id": "ticket",
            },
            //{"id": "debit_card"},
          ],
        },
        "back_urls": {
          "success": "https://www.example.com/success",
          "pending": "https://www.example.com/pending",
          "failure": "https://www.example.com/failure"
        }
      },
    );
    final response = await http.post(
      Uri.parse('https://api.mercadopago.com/checkout/preferences'),
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
      throw Exception('Error preferenceId');
    }
  }
}
