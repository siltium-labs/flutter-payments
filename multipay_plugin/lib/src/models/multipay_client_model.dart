import 'macro/macro_client_credentials.dart';
import 'mercadopago/client/mercadopago_client_credentials.dart';
import 'ualabis/ualabis_client_credentials.dart';
import 'viumi/viumi_client_credentials_model.dart';

///General model that will hold all available credentials needed to
///start the different checkout procedures.
///If `sandbox` is left unspecified, defaults to `true`.
class MultiPayClientModel {
  bool? sandbox = true;
  bool? mercadoPagoNativeCheckout = true;
  MacroClientCredentialsModel? macroCredentials;
  MercadoPagoClientCredentials? mercadoPagoCredentials;
  UalaBisClientCredentialsModel? ualaBisCredentials;
  ViumiClientCredentialsModel? viumiCredentials;

  MultiPayClientModel({
    this.macroCredentials,
    this.mercadoPagoCredentials,
    this.ualaBisCredentials,
    this.viumiCredentials,
    this.sandbox = true,
    this.mercadoPagoNativeCheckout = true,
  });

  ///Sets the credentials for MercadoPago.
  setMercadoPagoCredentials({
    required String publicKey,
    required String bearerToken,
  }) async {
    mercadoPagoCredentials = MercadoPagoClientCredentials(
      publicKey: publicKey,
      bearerToken: bearerToken,
    );
  }

  ///Sets the credentials for UalaBis.
  Future<void> setUalaBisCredentials({
    String? userName,
    String? clientId,
    String? clientSecret,
    String? grantType,
  }) async {
    ualaBisCredentials = UalaBisClientCredentialsModel(
      userName: userName,
      clientId: clientId,
      clientSecret: clientSecret,
      grantType: grantType,
    );
  }
}
