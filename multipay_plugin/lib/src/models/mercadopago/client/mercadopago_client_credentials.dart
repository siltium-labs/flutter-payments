class MercadoPagoClientCredentials {
  String? publicKey;
  String? preferenceId;
  String? bearerToken;
  String? url;
  bool hasCustomButton = false;

  MercadoPagoClientCredentials({
    this.preferenceId,
    this.publicKey,
    this.bearerToken,
    this.url,
  });
}
