library multipay_plugin;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multipay_plugin/src/mercadopago/mercado_pago_manager.dart';
import 'package:multipay_plugin/src/models/mercadopago/card/mercado_pago_card_holder_model.dart';
import 'package:multipay_plugin/src/models/mercadopago/card/mercado_pago_card_model.dart';
import 'package:multipay_plugin/src/models/mercadopago/client/inner_models/mercadopago_identification_model.dart';
import 'package:multipay_plugin/src/models/mercadopago/client/mercadopago_client_credentials.dart';
import 'package:multipay_plugin/src/models/mercadopago/items/mercadopago_item_model.dart';
import 'package:multipay_plugin/src/models/mercadopago/preferences/inner_models/mercadopago_preferences_back_urls.dart';
import 'package:multipay_plugin/src/models/mercadopago/preferences/mercadopago_preferences_request_model.dart';
import 'package:multipay_plugin/src/models/mercadopago/preferences/mercadopago_preferences_response_model.dart';
import 'package:multipay_plugin/src/models/multipay_client_model.dart';
import 'package:multipay_plugin/src/models/ualabis/ualabis_client_credentials.dart';
import 'package:multipay_plugin/src/pages/card_token_form_page.dart';
import 'package:multipay_plugin/src/ualabis/ualabis.dart';
import 'package:multipay_plugin/src/utility/loading_popup.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:multipay_plugin/src/models/multipay_client_model.dart';

class MultipayPlugin {
  ///Lets you create a customized button that leads to a data form.
  ///
  ///Saves a card data into a token
  ///
  ///All parameters besides the `MultiPayClientModel` and `BuildContext` are optional
  ///They let you customize the button and the form page
  getCardTokenGenerationButton(
    BuildContext context,
    MultiPayClientModel client, {
    Color? backgroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    double? borderWidth,
    Widget? content,
    double? height,
    Color? highlightColor,
    double? imagePadding,
    String? imagePath,
    String? imageUrl,
    double? width,
    AppBar? pageAppBar,
    BoxDecoration? cardBackDecoration,
    BoxDecoration? cardFrontDecoration,
    double? cardHeight,
    BoxDecoration? cardNumberFieldDecoration,
    String? cardNumberFieldPlaceholder,
    TextStyle? cardNumberFieldPlaceholderStyle,
    TextStyle? cardNumberFieldTextStyle,
    TextStyle? cardTextStyle,
    double? cardWidth,
    Color? createTokenButtonBackgroundColor,
    Color? createTokenButtonBorderColor,
    BorderRadius? createTokenButtonBorderRadius,
    double? createTokenButtonBorderWidth,
    Widget? createTokenButtonContent,
    double? createTokenButtonHeight,
    Color? createTokenButtonHighlightColor,
    double? createTokenButtonImagePadding,
    String? createTokenButtonImagePath,
    String? createTokenButtonImageUrl,
    double? createTokenButtonWidth,
    BoxDecoration? CVVFormDecoration,
    String? CVVFormPlaceholder,
    TextStyle? CVVFormPlaceholderStyle,
    TextStyle? CVVFormTextStyle,
    BoxDecoration? expirationDateFormDecoration,
    String? expirationDateFormPlaceholder,
    TextStyle? expirationDateFormPlaceholderStyle,
    TextStyle? expirationDateFormTextStyle,
    double? formWidth,
    double? horizontalSeparation,
    BoxDecoration? idFieldDecoration,
    String? idFieldPlaceholderText,
    TextStyle? idFieldPlaceholderTextStyle,
    TextStyle? idFieldTextStyle,
    BoxDecoration? idTypeDropdownDecoration,
    String? idTypeDropdownPlaceholderText,
    Color? idTypeDropdownPlaceholderTextColor,
    Color? idTypeDropdownTextColor,
    Color? loadingColor,
    BoxDecoration? nameFieldDecoration,
    String? nameFieldPlaceholder,
    TextStyle? nameFieldPlaceholderStyle,
    TextStyle? nameFieldTextStyle,
    Color? pageBackgroundColor,
    EdgeInsets? pagePadding,
    BoxDecoration? paymentMethodDropdownDecoration,
    String? paymentMethodDropdownPlaceholderText,
    Color? paymentMethodDropdownPlaceholderTextColor,
    Color? paymentMethodDropdownTextColor,
    bool? showSampleCard,
    double? verticalSeparation,
  }) {
    return _customButton(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CardTokenFormPage(
              client: client,
              appBar: pageAppBar,
              cardBackDecoration: cardBackDecoration,
              cardFrontDecoration: cardFrontDecoration,
              cardHeight: cardHeight,
              cardNumberFieldDecoration: cardNumberFieldDecoration,
              cardNumberFieldPlaceholder: cardNumberFieldPlaceholder,
              cardNumberFieldPlaceholderStyle: cardNumberFieldPlaceholderStyle,
              cardNumberFieldTextStyle: cardNumberFieldTextStyle,
              cardTextStyle: cardTextStyle,
              cardWidth: cardWidth,
              createTokenButtonBackgroundColor:
                  createTokenButtonBackgroundColor,
              createTokenButtonBorderColor: createTokenButtonBorderColor,
              createTokenButtonBorderRadius: createTokenButtonBorderRadius,
              createTokenButtonBorderWidth: createTokenButtonBorderWidth,
              createTokenButtonContent: createTokenButtonContent,
              createTokenButtonHeight: createTokenButtonHeight,
              createTokenButtonHighlightColor: createTokenButtonHighlightColor,
              createTokenButtonImagePadding: createTokenButtonImagePadding,
              createTokenButtonImagePath: createTokenButtonImagePath,
              createTokenButtonImageUrl: createTokenButtonImageUrl,
              createTokenButtonWidth: createTokenButtonWidth,
              CVVFormDecoration: CVVFormDecoration,
              CVVFormPlaceholder: CVVFormPlaceholder,
              CVVFormPlaceholderStyle: CVVFormPlaceholderStyle,
              CVVFormTextStyle: CVVFormTextStyle,
              expirationDateFormDecoration: expirationDateFormDecoration,
              expirationDateFormPlaceholder: expirationDateFormPlaceholder,
              expirationDateFormPlaceholderStyle:
                  expirationDateFormPlaceholderStyle,
              expirationDateFormTextStyle: expirationDateFormTextStyle,
              formWidth: formWidth,
              horizontalSeparation: horizontalSeparation,
              idFieldDecoration: idFieldDecoration,
              idFieldPlaceholderText: idFieldPlaceholderText,
              idFieldPlaceholderTextStyle: idFieldPlaceholderTextStyle,
              idFieldTextStyle: idFieldTextStyle,
              idTypeDropdownDecoration: idTypeDropdownDecoration,
              idTypeDropdownPlaceholderText: idTypeDropdownPlaceholderText,
              idTypeDropdownPlaceholderTextColor:
                  idTypeDropdownPlaceholderTextColor,
              idTypeDropdownTextColor: idTypeDropdownTextColor,
              loadingColor: loadingColor,
              nameFieldDecoration: nameFieldDecoration,
              nameFieldPlaceholder: nameFieldPlaceholder,
              nameFieldPlaceholderStyle: nameFieldPlaceholderStyle,
              nameFieldTextStyle: nameFieldTextStyle,
              pageBackgroundColor: pageBackgroundColor,
              pagePadding: pagePadding,
              paymentMethodDropdownDecoration: paymentMethodDropdownDecoration,
              paymentMethodDropdownPlaceholderText:
                  paymentMethodDropdownPlaceholderText,
              paymentMethodDropdownPlaceholderTextColor:
                  paymentMethodDropdownPlaceholderTextColor,
              paymentMethodDropdownTextColor: paymentMethodDropdownTextColor,
              showSampleCard: showSampleCard ?? true,
              verticalSeparation: verticalSeparation,
            ),
          ),
        );
      },
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      buttonContent: content,
      height: height,
      highlightColor: highlightColor,
      imagePadding: imagePadding ?? 0,
      imagePath: imagePath,
      imageUrl: imageUrl,
      width: width,
    );
  }

  ///Lets you customize the button for MercadoPago payment.
  ///
  ///Overrides the `ButtonRack` default button.
  ///`mercadoPagoPreferenceId` and all the product detail parameters are optional
  ///but having one of them is required for the procedure.
  getCustomMercadoPagoButton(
    BuildContext context,
    MultiPayClientModel client, {
    String? mercadoPagoPreferenceId,
    double? totalPrice,
    String? description,
    String? title,
    int? quantity,
    String? currencyId,
    String? categoryId,
    String? itemId,
    String? successURL,
    String? failURL,
    Color? borderColor,
    Color? backgroundColor,
    Color? highlightColor,
    Widget? buttonContent,
    double? width,
    double? height,
    double? borderWidth,
    BorderRadius? borderRadius,
  }) {
    assert(
      mercadoPagoPreferenceId != null ||
          (totalPrice != null &&
              title != null &&
              quantity != null &&
              itemId != null),
      "both mercadoPagoPreferenceId and product detail parameters are null, at least one of them should NOT be null",
    );

    client.mercadoPagoCredentials!.hasCustomButton = true;
    return _customButton(
      onTap: () async {
        await _mpCheckoutMethod(
          context,
          client: client.mercadoPagoCredentials!,
          sandbox: client.sandbox!,
          nativeCheckout: client.mercadoPagoNativeCheckout!,
          successURL: successURL!,
          failURL: failURL!,
          item: MercadoPagoItemModel(
            description: description,
            title: title,
            unitPrice: totalPrice,
            quantity: quantity,
            currencyId: currencyId ?? "ARS",
            categoryId: categoryId,
            id: itemId,
          ),
        );
      },
      borderColor: borderColor,
      backgroundColor: backgroundColor,
      highlightColor: highlightColor,
      buttonContent: buttonContent,
      width: width,
      height: height,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
    );
  }

  ///Lets you customize the button for UalaBis payment.
  ///
  ///Overrides the `ButtonRack` default button.
  getCustomUalaBisButton(
    BuildContext context,
    MultiPayClientModel client, {
    double? totalPrice,
    String? description,
    int? quantity,
    String? currencyId,
    String? categoryId,
    String? itemId,
    String? successURL,
    String? failURL,
    Color? borderColor,
    Color? backgroundColor,
    Color? highlightColor,
    Widget? buttonContent,
    double? width,
    double? height,
    double? borderWidth,
    BorderRadius? borderRadius,
  }) {
    client.ualaBisCredentials!.hasCustomButton = true;
    return _customButton(
      onTap: () async {
        await _ualaBisCheckoutMethod(
          context,
          client: client.ualaBisCredentials!,
          sandbox: client.sandbox!,
          successURL: successURL!,
          failURL: failURL!,
          totalPrice: totalPrice!,
          description: description,
        );
      },
      borderColor: borderColor,
      backgroundColor: backgroundColor,
      highlightColor: highlightColor,
      buttonContent: buttonContent,
      width: width,
      height: height,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
    );
  }

  ///Generates a default button for each payment method credentials loaded in
  ///`MultipayClientModel`.
  ///
  ///Its buttons are overriden by the respective custom buttons.
  ///
  ///`mercadoPagoPreferenceId` and all the product detail parameters are optional
  ///but having one of them is required for the procedure.
  getPaymentButtonsRack(
    BuildContext context,
    MultiPayClientModel client, {
    String? mercadoPagoPreferenceId,
    double? totalPrice,
    String? description,
    String? title,
    int? quantity,
    String? currencyId,
    String? categoryId,
    String? itemId,
    String? successURL,
    String? failURL,
    double? buttonHeight,
    double? buttonWidth,
    double? separation,
    bool vertical = true,
  }) {
    assert(
      mercadoPagoPreferenceId != null ||
          (totalPrice != null &&
              title != null &&
              quantity != null &&
              itemId != null),
      "both mercadoPagoPreferenceId and product detail parameters are null, at least one of them should NOT be null",
    );
    return vertical
        ? Column(
            children: [
              if (client.mercadoPagoCredentials != null &&
                  !client.mercadoPagoCredentials!.hasCustomButton) ...[
                _customButton(
                  onTap: () async {
                    await _mpCheckoutMethod(
                      context,
                      client: client.mercadoPagoCredentials!,
                      sandbox: client.sandbox!,
                      nativeCheckout: client.mercadoPagoNativeCheckout!,
                      successURL: successURL!,
                      failURL: failURL!,
                      item: MercadoPagoItemModel(
                        description: description,
                        title: title,
                        unitPrice: totalPrice,
                        quantity: quantity,
                        currencyId: currencyId ?? "ARS",
                        categoryId: categoryId,
                        id: itemId,
                      ),
                    );
                  },
                  borderColor: const Color.fromARGB(255, 0, 158, 227),
                  highlightColor: const Color.fromARGB(127, 0, 138, 214),
                  imagePadding: 10,
                  height: buttonHeight,
                  width: buttonWidth,
                  imageUrl:
                      "https://logotipoz.com/wp-content/uploads/2021/10/version-horizontal-large-logo-mercado-pago.webp",
                ),
                SizedBox(
                  height: separation ?? 15,
                ),
              ],
              if (client.ualaBisCredentials != null &&
                  !client.ualaBisCredentials!.hasCustomButton) ...[
                _customButton(
                  onTap: () async {
                    await _ualaBisCheckoutMethod(
                      context,
                      client: client.ualaBisCredentials!,
                      sandbox: client.sandbox!,
                      successURL: successURL!,
                      failURL: failURL!,
                      totalPrice: totalPrice!,
                      description: description,
                    );
                  },
                  borderColor: const Color.fromARGB(255, 2, 42, 155),
                  highlightColor: const Color.fromARGB(127, 42, 75, 170),
                  imagePadding: 10,
                  height: buttonHeight,
                  width: buttonWidth,
                  imageUrl:
                      "https://www.uala.com.ar/_next/static/media/logotipo-uala.f9c7a2c4.png",
                ),
                /* SizedBox(
                  height: separation ?? 15,
                ), */
              ],
              /* if (client.viumiCredentials != null) ...[
          _customButton(
            onTap: () {},
            borderColor: const Color.fromARGB(255, 69, 39, 160),
            highlightColor: const Color.fromARGB(127, 106, 82, 179),
            height: buttonHeight,
            width: buttonWidth,
            imagePath: "packages/multipay/lib/assets/images/viumiTextLogo.png",
          ),
        ], */
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (client.mercadoPagoCredentials != null &&
                  !client.mercadoPagoCredentials!.hasCustomButton) ...[
                _customButton(
                  width: buttonWidth ?? 80,
                  onTap: () async {
                    await _mpCheckoutMethod(
                      context,
                      client: client.mercadoPagoCredentials!,
                      sandbox: client.sandbox!,
                      successURL: successURL!,
                      failURL: failURL!,
                      nativeCheckout: client.mercadoPagoNativeCheckout!,
                      item: MercadoPagoItemModel(
                        description: description,
                        title: title,
                        unitPrice: totalPrice,
                        quantity: quantity,
                        currencyId: currencyId ?? "ARS",
                        categoryId: categoryId,
                        id: itemId,
                      ),
                    );
                  },
                  borderColor: const Color.fromARGB(255, 0, 158, 227),
                  highlightColor: const Color.fromARGB(127, 0, 138, 214),
                  imagePadding: 1,
                  height: buttonHeight,
                  imageUrl:
                      "https://downloadr2.apkmirror.com/wp-content/uploads/2023/02/78/63fa5f08155a6-384x384.png",
                ),
                SizedBox(
                  width: separation ?? 15,
                ),
              ],
              if (client.ualaBisCredentials != null &&
                  !client.ualaBisCredentials!.hasCustomButton) ...[
                _customButton(
                  width: buttonWidth ?? 80,
                  onTap: () async {
                    await _ualaBisCheckoutMethod(
                      context,
                      client: client.ualaBisCredentials!,
                      sandbox: client.sandbox!,
                      successURL: successURL!,
                      failURL: failURL!,
                      totalPrice: totalPrice!,
                      description: description,
                    );
                  },
                  borderColor: const Color.fromARGB(255, 2, 42, 155),
                  highlightColor: const Color.fromARGB(127, 42, 75, 170),
                  imagePadding: 12,
                  height: buttonHeight,
                  imageUrl:
                      "https://static.wikia.nocookie.net/logopedia/images/d/d8/Ual%C3%A1_old_I.png/revision/latest/scale-to-width-down/250?cb=20230310193656",
                ),
                /* const SizedBox(
                  height: separation ?? 15,
                ), */
              ],
            ],
          );
  }
}

_mpCheckoutMethod(
  BuildContext context, {
  required MercadoPagoClientCredentials client,
  required String successURL,
  required String failURL,
  required MercadoPagoItemModel item,
  required bool sandbox,
  String? mercadoPagoPreferenceId,
  required bool nativeCheckout,
}) async {
  MercadoPagoPreferencesResponseModel? prefs;
  await LoadingPopup(
      context: context,
      onLoading: _mpGetPreferences(
          mercadoPagoPreferenceId, client, successURL, failURL, item),
      onResult: (value) {
        prefs = value;
      }).show();

  if (nativeCheckout) {
    const platform = MethodChannel("multipay_plugin");
    try {
      Map<String, dynamic>? result =
          await (platform.invokeMapMethod<String, dynamic>(
        "mpCheckout",
        {
          "publicKey": client.publicKey!,
          "preferenceId": prefs!.id!,
        },
      ));
    } on PlatformException catch (e) {
      print(e);
    }
  } else {
    List<String> uri =
        _getUrl(sandbox ? prefs!.sandboxInitPoint! : prefs!.initPoint!);
    var url = Uri.https(
      uri[0],
      uri[1],
      {
        uri[2]: uri[3],
      },
    );
    if (!await launchUrl(url)) {
      throw Exception("Could not launch ${url.path}");
    }
  }
}

Future<MercadoPagoPreferencesResponseModel?> _mpGetPreferences(
    mercadoPagoPreferenceId, client, successURL, failURL, item) async {
  return mercadoPagoPreferenceId != null
      ? await MercadoPagoManager().getPurchaseFromPreference(
          mercadoPagoPreferenceId,
          client,
        )
      : await MercadoPagoManager().getPurchasePreferenceId(
          MercadoPagoPreferencesRequestModel(
            backUrls: MercadoPagoPreferencesBackUrls(
              success: successURL,
              failure: failURL,
            ),
            items: [item],
          ),
          client,
        );
}

_ualaBisCheckoutMethod(
  BuildContext context, {
  required UalaBisClientCredentialsModel client,
  required String successURL,
  required String failURL,
  required double totalPrice,
  required bool sandbox,
  String? description,
}) async {
  Map<String, dynamic>? checkout;
  await LoadingPopup(
      context: context,
      onLoading: _ualaBisAPICalls(
          client, sandbox, totalPrice, description, successURL, failURL),
      onResult: (value) {
        checkout = value;
      }).show();

  String url = (checkout!["links"])["checkoutLink"];
  List<String> uriStrings = url.split(".com");
  uriStrings[0] += ".com";
  uriStrings[0] = uriStrings[0].substring(8);

  Uri checkoutURL = Uri.https(uriStrings[0], uriStrings[1]);

  if (!await launchUrl(checkoutURL)) {
    throw Exception("Could not launch ${checkoutURL.path}");
  }
}

Future<Map<String, dynamic>?> _ualaBisAPICalls(
    client, sandbox, totalPrice, description, successURL, failURL) async {
  var generateClientToken = await UalaBisManager().postRequestAccessToken(
    client,
    sandbox,
  );

  return await UalaBisManager().postUalaBisCheckout(
    client: generateClientToken,
    sandboxEnvironment: sandbox,
    totalPrice: totalPrice.toString(),
    description: description ?? "",
    callbackSuccess: successURL,
    callbackFail: failURL,
  );
}

_customButton({
  required Function() onTap,
  Color? borderColor,
  Color? backgroundColor,
  Color? highlightColor,
  String? imageUrl,
  String? imagePath,
  double imagePadding = 0,
  Widget? buttonContent,
  double? width,
  double? height,
  double? borderWidth,
  BorderRadius? borderRadius,
}) {
  return Material(
    child: Center(
      child: Ink(
        width: width ?? 200,
        height: height ?? 50,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: Border.all(
            color: borderColor ?? Colors.white,
            width: borderWidth ?? 1.5,
          ),
          borderRadius: borderRadius ??
              const BorderRadius.all(
                Radius.circular(50),
              ),
        ),
        child: InkWell(
          onTap: onTap,
          highlightColor: highlightColor,
          borderRadius: borderRadius ??
              const BorderRadius.all(
                Radius.circular(50),
              ),
          child: buttonContent ??
              Center(
                child: Padding(
                  padding: EdgeInsets.all(imagePadding),
                  child: imageUrl != null
                      ? Image.network(imageUrl)
                      : imagePath != null
                          ? Image.asset(imagePath)
                          : const SizedBox.shrink(),
                ),
              ),
        ),
      ),
    ),
  );
}

_getUrl(String path) {
  List<String> dividePath = path.substring(8).split(".ar");
  dividePath[0] += ".ar";
  dividePath.addAll(dividePath[1].split("?"));
  dividePath.removeAt(1);
  dividePath.addAll(dividePath[2].split("="));
  dividePath.removeAt(2);

  return dividePath;
}
