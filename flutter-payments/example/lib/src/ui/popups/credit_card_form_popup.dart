// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_payments/flutter_payments.dart';
import 'package:flutter_payments_example/src/ui/components/rounded_button_component.dart';

import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';

import '../../../values/k_colors.dart';
import '../../../values/k_values.dart';
import 'loading_popup.dart';

class CreditCardFormPopup {
  final BuildContext context;
  String accessToken;

  CreditCardFormPopup({
    required this.context,
    required this.accessToken,
  });

  final double radius = 20;

  Future show() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return _dialog();
      },
    );
  }

  _dialog() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        children: <Widget>[
          _background(),
          _card(),
        ],
      ),
    );
  }

  _background() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      color: kPrimary.withOpacity(0.4),
    );
  }

  _card() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          child: _body(),
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }

  _body() {
    return Stack(
      children: <Widget>[
        CreditCardFormPopupDialog(
          context: context,
          accessToken: accessToken,
        ),
        _buttonExit(),
      ],
    );
  }

  _buttonExit() {
    return Visibility(
      //visible: isCancellable,
      visible: true,
      child: Positioned.fill(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              right: 10,
            ),
            child: GestureDetector(
              key: const Key('cancelCreditCardFormPopupExitButton'),
              onTap: () {
                Navigator.pop(context, false);
              },
              child: const Icon(
                Icons.close_rounded,
                size: 25,
                color: kPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CreditCardFormPopupDialog extends StatefulWidget {
  final BuildContext context;
  String accessToken;

  CreditCardFormPopupDialog({
    required this.context,
    required this.accessToken,
    Key? key,
  }) : super(key: key);

  @override
  State<CreditCardFormPopupDialog> createState() =>
      _CreditCardFormPopupDialogState();
}

class _CreditCardFormPopupDialogState extends State<CreditCardFormPopupDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;

  @override
  void initState() {
    super.initState();
  }

  OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );

  Future show() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return build(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  _content() {
    return SingleChildScrollView(
      child: Container(
        key: const Key('cancelCreditCardFormPopupContent'),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //children: _getChildren(),
          children: [
            CreditCardWidget(
              glassmorphismConfig:
                  useGlassMorphism ? Glassmorphism.defaultConfig() : null,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              bankName: 'Siltium Bank',
              frontCardBorder: !useGlassMorphism
                  ? Border.all(
                      color: Colors.grey,
                    )
                  : null,
              backCardBorder: !useGlassMorphism
                  ? Border.all(
                      color: Colors.grey,
                    )
                  : null,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              //cardBgColor: cardBgColor,
              cardBgColor: kPrimary,
              backgroundImage: useBackgroundImage ? 'assets/card_bg.png' : null,
              isSwipeGestureEnabled: true,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              customCardTypeIcons: <CustomCardTypeIcon>[
                CustomCardTypeIcon(
                  cardType: CardType.mastercard,
                  cardImage: Image.asset(
                    'assets/mastercard.png',
                    height: 48,
                    width: 48,
                  ),
                ),
              ],
            ),
            CreditCardForm(
              formKey: formKey,
              obscureCvv: true,
              obscureNumber: true,
              cardNumber: cardNumber,
              cvvCode: cvvCode,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              cardHolderName: cardHolderName,
              expiryDate: expiryDate,
              themeColor: kPrimary,
              textColor: Colors.black,
              cardNumberDecoration: InputDecoration(
                labelText: 'Number',
                hintText: 'XXXX XXXX XXXX XXXX',
                hintStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: border,
                enabledBorder: border,
              ),
              expiryDateDecoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: border,
                enabledBorder: border,
                labelText: 'Expired Date',
                hintText: 'XX/XX',
              ),
              cvvCodeDecoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: border,
                enabledBorder: border,
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              cardHolderDecoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: border,
                enabledBorder: border,
                labelText: 'Card Holder',
              ),
              onCreditCardModelChange: (CreditCardModel creditCardModel) {
                setState(() {
                  cardNumber = creditCardModel.cardNumber;
                  expiryDate = creditCardModel.expiryDate;
                  cardHolderName = creditCardModel.cardHolderName;
                  cvvCode = creditCardModel.cvvCode;
                  isCvvFocused = creditCardModel.isCvvFocused;
                });
              },
            ),
            /* const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Glassmorphism',
                    style: TextStyle(
                      color: kPrimary,
                      fontSize: kFontSize40,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: useGlassMorphism,
                    inactiveTrackColor: Colors.grey,
                    activeColor: Colors.white,
                    activeTrackColor: colorE5D1B2,
                    onChanged: (bool value) => setState(
                      () {
                        useGlassMorphism = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Card Image',
                    style: TextStyle(
                      color: kPrimary,
                      fontSize: kFontSize40,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: useBackgroundImage,
                    inactiveTrackColor: Colors.grey,
                    activeColor: Colors.white,
                    activeTrackColor: colorE5D1B2,
                    onChanged: (bool value) => setState(
                      () {
                        useBackgroundImage = value;
                      },
                    ),
                  ),
                ],
              ),
            ), */
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: onValidate,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[
                      colorB58D67,
                      colorB58D67,
                      colorE5D1B2,
                      colorF9EED2,
                      colorFFFFFD,
                      colorF9EED2,
                      colorB58D67,
                    ],
                    begin: Alignment(-1, -4),
                    end: Alignment(1, 4),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  'Validate',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'halter',
                    fontSize: 14,
                    package: 'flutter_credit_card',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buttonAccept() {
    return RoundedButtonComponent(
      width: double.infinity,
      height: 50,
      onPressed: () {
        Navigator.pop(context);
      },
      backgroundColor: kPrimary,
      borderColor: kPrimary,
      text: "Validar",
      fontSize: kFontSize40,
      fontWeight: FontWeight.w700,
      textColor: kWhite,
    );
  }

  void onValidate() async {
    if (formKey.currentState!.validate()) {
      print('valid!');
      getTokenCardMercadoPago();
    } else {
      print('invalid!');
    }
  }

  Future<String?> _getTokenCardMercadoPago() async {
    String? token;
    try {
      List<String> expDate = expiryDate.split("/");
      String month = expDate[0];
      String year = "20${expDate[1]}";
      token = await FlutterPayments.getTokenCardMercadoPago(
        accessToken: widget.accessToken,
        //documentType: "DNI",
        documentNumber: "12345678",
        cardNumber: cardNumber.replaceAll(' ', ''),
        cardHolder: cardHolderName,
        expirationMonth: month,
        expirationYear: year,
        cvv: cvvCode,
      );
    } catch (e) {}

    return token;
  }

  void getTokenCardMercadoPago() async {
    await LoadingPopup(
      context: context,
      onLoading: _getTokenCardMercadoPago(),
      onError: (err) {
        _onError(err);
      },
      onResult: (data) {
        _onResultData(data);
      },
    ).show();
  }

  void _onError(dynamic err) {
    print("Error");
  }

  void _onResultData(String? accessToken) async {
    if (accessToken != null) {
      print("Token Card: $accessToken");
    }
  }
}
