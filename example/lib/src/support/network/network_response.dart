import 'dart:typed_data';

class NetworkResponse {
  String? response;
  int? statusCode;
  String? message;
  Uint8List? bodyBytes;

  NetworkResponse(
      {this.response,
        this.statusCode,
        this.message,
        this.bodyBytes});
}
