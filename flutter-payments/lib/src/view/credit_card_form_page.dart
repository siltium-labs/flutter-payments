import 'package:flutter/material.dart';

import '../../flutter_payments.dart';
import '../components/common/loading_popup.dart';
import '../components/common/rounded_button_component.dart';
import '../components/credit_card_brand.dart';
import '../components/credit_card_form.dart';
import '../components/credit_card_model.dart';
import '../components/credit_card_widget.dart';
import '../components/custom_card_type_icon.dart';
import '../components/glassmorphism_config.dart';
import '../values/k_colors.dart';
import '../values/k_values.dart';

class CreditCardFormPage extends StatefulWidget {
  final Color? themColor;

  const CreditCardFormPage({
    Key? key,
    this.themColor,
  }) : super(key: key);

  @override
  State<CreditCardFormPage> createState() => _CreditCardFormPageState();
}

class _CreditCardFormPageState extends State<CreditCardFormPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String documentType = "";
  String documentNumber = "";

  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;

  OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 75,
                  vertical: 25,
                ),
                child: CreditCardWidget(
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Siltium Bank',
                  frontCardBorder: !useGlassMorphism
                      ? Border.all(
                          color: widget.themColor ?? kPrimary,
                        )
                      : null,
                  backCardBorder: !useGlassMorphism
                      ? Border.all(
                          color: widget.themColor ?? kPrimary,
                        )
                      : null,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  //cardBgColor: cardBgColor,
                  cardBgColor: kPrimary,
                  backgroundImage: useBackgroundImage
                      ? 'images/mercado_pago/card_bg.png'
                      : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        'images/mercado_pago/mastercard.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              ),
              CreditCardForm(
                themeColor: kPrimary,
                formKey: formKey,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cvvCode: cvvCode,
                cardHolderName: cardHolderName,
                documentType: documentType,
                documentNumber: documentNumber,
                isCardNumberVisible: true,
                isExpiryDateVisible: true,
                obscureCvv: true,
                obscureNumber: true,
                isHolderNameVisible: true,
                textColor: Colors.black,

                /* cardNumberDecoration: InputDecoration(
                  labelText: 'Number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: border,
                  enabledBorder: border,
                ), */
                cardNumberDecoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Card number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.credit_card,
                    color: widget.themColor ?? kPrimary,
                  ),
                ),
                /* expiryDateDecoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                ), */
                expiryDateDecoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: widget.themColor ?? kPrimary,
                  ),
                ),
                /* cvvCodeDecoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'CVV',
                  hintText: 'XXX',
                ), */
                cvvCodeDecoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'CVV',
                  hintText: 'XXX',
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: widget.themColor ?? kPrimary,
                  ),
                ),
                /* cardHolderDecoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'Card Holder',
                ), */
                cardHolderDecoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Card Holder',
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.person,
                    color: widget.themColor ?? kPrimary,
                  ),
                ),
                documentTypeDecoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Doc. Type',
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.person,
                    color: widget.themColor ?? kPrimary,
                  ),
                ),
                documentNumberDecoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Document Number',
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.person,
                    color: widget.themColor ?? kPrimary,
                  ),
                ),
                onCreditCardModelChange: (CreditCardModel creditCardModel) {
                  setState(() {
                    cardNumber = creditCardModel.cardNumber;
                    expiryDate = creditCardModel.expiryDate;
                    cardHolderName = creditCardModel.cardHolderName;
                    cvvCode = creditCardModel.cvvCode;
                    isCvvFocused = creditCardModel.isCvvFocused;
                    documentType = creditCardModel.documentType;
                    documentNumber = creditCardModel.documentNumber;
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
              const SizedBox(height: 20),
              _buttonAccept()
            ],
          ),
        ),
      ),
    );
  }

  _buttonAccept() {
    return RoundedButtonComponent(
      backgroundColor: widget.themColor ?? kPrimary,
      borderColor: widget.themColor ?? kPrimary,
      width: double.infinity,
      borderRadius: 15,
      height: 50,
      onPressed: () {
        onValidate();
      },
      text: "Pagar",
      fontSize: kFontSize40,
      fontWeight: kFontWeightBold,
      textColor: kWhite,
    );
  }

  void onValidate() {
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
        accessToken: kAccessTokenTest,
        documentType: documentType,
        documentNumber: documentNumber,
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
      //onLoading: Future.delayed(const Duration(seconds: 1)),
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
