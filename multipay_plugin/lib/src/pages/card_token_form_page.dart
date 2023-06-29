// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_field, prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multipay_plugin/multipay_plugin.dart';
import 'package:multipay_plugin/src/models/mercadopago/payment/inner_models/mercadopago_payment_method_settings_model.dart';
import 'package:multipay_plugin/src/utility/Item_data_form_component.dart';
import 'package:multipay_plugin/src/utility/futuristic.dart';
import 'package:multipay_plugin/src/utility/loading_component.dart';

import '../mercadopago/mercado_pago_manager.dart';
import '../models/mercadopago/card/mercado_pago_card_holder_model.dart';
import '../models/mercadopago/card/mercado_pago_card_model.dart';
import '../models/mercadopago/client/inner_models/mercadopago_identification_model.dart';
import '../models/mercadopago/client/mercadopago_client_credentials.dart';
import '../models/mercadopago/client/mercadopago_identification_type_model.dart';
import '../models/mercadopago/payment/mercadopago_payment_method_model.dart';
import '../utility/loading_popup.dart';

class CardTokenFormPage extends StatefulWidget {
  late MultiPayClientModel mtpclient;
  bool showSampleCard = true;
  double? cardHeight, cardWidth;
  BoxDecoration? cardFrontDecoration, cardBackDecoration;
  TextStyle? cardTextStyle;
  Color? loadingColor;
  AppBar? appBar;
  EdgeInsets? pagePadding;
  double? formWidth;
  BoxDecoration? paymentMethodDropdownDecoration;
  String? paymentMethodDropdownPlaceholderText;
  Color? paymentMethodDropdownPlaceholderTextColor;
  Color? paymentMethodDropdownTextColor;
  BoxDecoration? cardNumberFieldDecoration;
  String? cardNumberFieldPlaceholder;
  TextStyle? cardNumberFieldTextStyle, cardNumberFieldPlaceholderStyle;
  double? horizontalSeparation;
  BoxDecoration? expirationDateFormDecoration;
  TextStyle? expirationDateFormTextStyle;
  String? expirationDateFormPlaceholder;
  TextStyle? expirationDateFormPlaceholderStyle;
  BoxDecoration? CVVFormDecoration;
  TextStyle? CVVFormTextStyle;
  String? CVVFormPlaceholder;
  TextStyle? CVVFormPlaceholderStyle;
  BoxDecoration? nameFieldDecoration;
  TextStyle? nameFieldTextStyle;
  String? nameFieldPlaceholder;
  TextStyle? nameFieldPlaceholderStyle;
  BoxDecoration? idTypeDropdownDecoration;
  String? idTypeDropdownPlaceholderText;
  Color? idTypeDropdownPlaceholderTextColor;
  Color? idTypeDropdownTextColor;
  BoxDecoration? idFieldDecoration;
  TextStyle? idFieldTextStyle;
  String? idFieldPlaceholderText;
  TextStyle? idFieldPlaceholderTextStyle;
  Color? createTokenButtonBackgroundColor;
  Color? createTokenButtonBorderColor;
  BorderRadius? createTokenButtonBorderRadius;
  double? createTokenButtonBorderWidth;
  Widget? createTokenButtonContent;
  double? createTokenButtonHeight;
  Color? createTokenButtonHighlightColor;
  double? createTokenButtonImagePadding;
  String? createTokenButtonImagePath;
  String? createTokenButtonImageUrl;
  double? createTokenButtonWidth;
  double? verticalSeparation;
  Color? pageBackgroundColor;

  CardTokenFormPage({
    required client,
    this.showSampleCard = true,
    this.cardBackDecoration,
    this.cardFrontDecoration,
    this.cardHeight,
    this.cardTextStyle,
    this.cardWidth,
    this.appBar,
    this.cardNumberFieldDecoration,
    this.cardNumberFieldPlaceholder,
    this.cardNumberFieldPlaceholderStyle,
    this.cardNumberFieldTextStyle,
    this.createTokenButtonBackgroundColor,
    this.createTokenButtonBorderColor,
    this.createTokenButtonBorderRadius,
    this.createTokenButtonBorderWidth,
    this.createTokenButtonContent,
    this.createTokenButtonHeight,
    this.createTokenButtonHighlightColor,
    this.createTokenButtonImagePadding,
    this.createTokenButtonImagePath,
    this.createTokenButtonImageUrl,
    this.createTokenButtonWidth,
    this.CVVFormDecoration,
    this.CVVFormPlaceholder,
    this.CVVFormPlaceholderStyle,
    this.CVVFormTextStyle,
    this.expirationDateFormDecoration,
    this.expirationDateFormPlaceholder,
    this.expirationDateFormPlaceholderStyle,
    this.expirationDateFormTextStyle,
    this.formWidth,
    this.horizontalSeparation,
    this.idFieldDecoration,
    this.idFieldPlaceholderText,
    this.idFieldPlaceholderTextStyle,
    this.idFieldTextStyle,
    this.idTypeDropdownDecoration,
    this.idTypeDropdownPlaceholderText,
    this.idTypeDropdownPlaceholderTextColor,
    this.idTypeDropdownTextColor,
    this.loadingColor,
    this.nameFieldDecoration,
    this.nameFieldPlaceholder,
    this.nameFieldPlaceholderStyle,
    this.nameFieldTextStyle,
    this.pageBackgroundColor,
    this.pagePadding,
    this.paymentMethodDropdownDecoration,
    this.paymentMethodDropdownPlaceholderText,
    this.paymentMethodDropdownPlaceholderTextColor,
    this.paymentMethodDropdownTextColor,
    this.verticalSeparation,
    super.key,
  }) {
    mtpclient = client;
  }

  @override
  State<CardTokenFormPage> createState() => _CardTokenFormPageState();
}

class _CardTokenFormPageState extends State<CardTokenFormPage>
    with TickerProviderStateMixin {
  List<MercadoPagoPaymentMethodModel>? paymentMethods = [];
  List<MercadoPagoIdentificationTypeModel> idTypes = [];
  List<String> paymentMethodNames = [];
  List<String> idNames = [];
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardDateController = TextEditingController();
  final TextEditingController _cardCVVController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _DNIController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  bool _validCardNumber = true;
  bool _validDate = true;
  bool _validCVV = true;
  bool _validName = true;
  bool _validDNI = true;
  bool _drawDiagonal = true;
  bool _printSpace = true;
  String? _dniTypeSelectedItem;
  String? _paymentMethodSelectedItem;
  MercadoPagoPaymentMethodModel? _currentPaymentMethod;
  MercadoPagoIdentificationTypeModel? _currentIdType;

  late AnimationController controller;
  late Animation<double> animation;
  late AnimationController returnController;
  late Animation<double> returnAnimation;
  bool isFront = true;
  double rotation = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    returnController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Futuristic(
      autoStart: true,
      futureBuilder: () => _getPaymentMethodsNDNITypes(),
      busyBuilder: (context) => loadingComponent(
        true,
        color: widget.loadingColor ?? Colors.blue,
      ),
      dataBuilder: (context, data) => _bodyContent(),
      errorBuilder: (context, error, retry) => _errorContent(),
    );
  }

  _bodyContent() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: widget.appBar ?? AppBar(),
      backgroundColor: widget.pageBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: widget.pagePadding ?? const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.showSampleCard) ...[
                _sampleCard(),
                SizedBox(
                  height: widget.verticalSeparation ?? 15,
                ),
              ],
              paymentMethodDropdown(),
              SizedBox(
                height: widget.verticalSeparation ?? 15,
              ),
              cardNumberField(),
              SizedBox(
                height: widget.verticalSeparation ?? 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _expirationDateField(),
                  SizedBox(
                    width: widget.horizontalSeparation ?? 20,
                  ),
                  _CVVField(),
                ],
              ),
              SizedBox(
                height: widget.verticalSeparation ?? 15,
              ),
              _nameField(),
              SizedBox(
                height: widget.verticalSeparation ?? 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _idTypeDropdown(),
                  SizedBox(
                    width: widget.horizontalSeparation ?? 20,
                  ),
                  _idField(),
                ],
              ),
              SizedBox(
                height: widget.verticalSeparation ?? 15,
              ),
              _customButton(
                onTap: () async {
                  List<String> aux = _cardDateController.text.split("/");
                  String year = "20${aux[1]}";
                  String month = aux[0];
                  await mpGetCardId(
                    context,
                    client: widget.mtpclient.mercadoPagoCredentials!,
                    securityCode: _cardCVVController.text,
                    cardNumber: _cardNumberController.text
                        .replaceAll(RegExp('\\s+'), ""),
                    expirationYear: year,
                    expirationMonth: month,
                    name: _cardNameController.text,
                    dniNumber: _DNIController.text,
                    dniType: _currentIdType!,
                    paymentMethod: _currentPaymentMethod!,
                  );
                },
                backgroundColor: widget.createTokenButtonBackgroundColor ??
                    Colors.white, //backgroundColor,
                borderColor: widget.createTokenButtonBorderColor ?? Colors.blue,
                borderRadius: widget.createTokenButtonBorderRadius ??
                    const BorderRadius.all(Radius.circular(50)),
                borderWidth: widget.createTokenButtonBorderWidth ?? 2,
                buttonContent: widget.createTokenButtonContent ??
                    const Center(
                      child: Text("Generar Token"),
                    ),
                height: widget.createTokenButtonHeight,
                highlightColor: widget.createTokenButtonHighlightColor,
                imagePadding: widget.createTokenButtonImagePadding ?? 0,
                imagePath: widget.createTokenButtonImagePath,
                imageUrl: widget.createTokenButtonImageUrl,
                width: widget.createTokenButtonWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _idTypeDropdown() {
    return Container(
      width: widget.formWidth != null && widget.horizontalSeparation != null
          ? (widget.formWidth! - widget.horizontalSeparation!) * 0.35
          : widget.formWidth != null
              ? (widget.formWidth! - 20) * 0.35
              : 70,
      decoration: widget.idTypeDropdownDecoration ??
          BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
      child: ItemDataFormComponent.dropDown(
        items: idNames,
        dropdownPadding: const EdgeInsets.only(left: 10),
        placeHolder: widget.idTypeDropdownPlaceholderText ?? "Tipo",
        placeholderDropdownItemColor:
            widget.idTypeDropdownPlaceholderTextColor ?? Colors.grey,
        dropdownItemColor: widget.idTypeDropdownTextColor ?? Colors.black,
        selectedItem: _dniTypeSelectedItem,
        onChange: (value) {
          if (rotation != 0) {
            _onEndAnimation();
          }
          for (MercadoPagoIdentificationTypeModel id in idTypes) {
            if (value == id.name!) {
              _currentIdType = id;
            }
          }
          _dniTypeSelectedItem = value;
          setState(() {});
        },
      ),
    );
  }

  Container _idField() {
    return Container(
      width: widget.formWidth != null && widget.horizontalSeparation != null
          ? (widget.formWidth! - widget.horizontalSeparation!) * 0.55
          : widget.formWidth != null
              ? (widget.formWidth! - 20) * 0.55
              : 110,
      decoration: widget.idFieldDecoration ??
          BoxDecoration(
            border: Border.all(
              color: _validDNI ? Colors.black : Colors.red,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
      child: ItemDataFormComponent.text(
        controller: _DNIController,
        textStyle: widget.idFieldTextStyle ??
            TextStyle(
              color: _validDNI ? Colors.black : Colors.red,
            ),
        placeHolder: widget.idFieldPlaceholderText ?? "DNI",
        onPress: rotation == 0 ? () {} : () => _onEndAnimation(),
        inputTextAlign: TextAlign.center,
        placeholderStyle: widget.idFieldPlaceholderTextStyle ??
            const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
      ),
    );
  }

  Container _nameField() {
    return Container(
      width: widget.formWidth ?? 200,
      decoration: widget.nameFieldDecoration ??
          BoxDecoration(
            border: Border.all(
              color: _validName ? Colors.black : Colors.red,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
      child: ItemDataFormComponent.text(
        controller: _cardNameController,
        textStyle: widget.nameFieldTextStyle ??
            TextStyle(
              color: _validName ? Colors.black : Colors.red,
            ),
        placeHolder: widget.nameFieldPlaceholder ?? "Nombre",
        inputTextAlign: TextAlign.center,
        placeholderStyle: widget.nameFieldPlaceholderStyle ??
            const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
        onPress: rotation == 0 ? () {} : () => _onEndAnimation(),
        onTextChange: (value) {
          setState(() {});
        },
      ),
    );
  }

  Container _CVVField() {
    return Container(
      width: widget.formWidth != null && widget.horizontalSeparation != null
          ? (widget.formWidth! - widget.horizontalSeparation!) / 2
          : widget.formWidth != null
              ? (widget.formWidth! - 20) / 2
              : 90,
      decoration: widget.CVVFormDecoration ??
          BoxDecoration(
            border: Border.all(
              color: _validCVV ? Colors.black : Colors.red,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
      child: ItemDataFormComponent.number(
        controller: _cardCVVController,
        textStyle: widget.CVVFormTextStyle ??
            TextStyle(
              color: _validCVV ? Colors.black : Colors.red,
            ),
        placeholder: widget.CVVFormPlaceholder ?? "CVV",
        isPassword: true,
        inputTextAlign: TextAlign.center,
        onPress: () => _onRotate(),
        onTextChange: (value) {
          setState(() {});
        },
        placeholderStyle: widget.CVVFormPlaceholderStyle ??
            const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
      ),
    );
  }

  Container _expirationDateField() {
    return Container(
      width: widget.formWidth != null && widget.horizontalSeparation != null
          ? (widget.formWidth! - widget.horizontalSeparation!) / 2
          : widget.formWidth != null
              ? (widget.formWidth! - 20) / 2
              : 90,
      decoration: widget.expirationDateFormDecoration ??
          BoxDecoration(
            border: Border.all(
              color: _validDate ? Colors.black : Colors.red,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
      child: ItemDataFormComponent.text(
        controller: _cardDateController,
        keyboardType: TextInputType.number,
        textStyle: widget.expirationDateFormTextStyle ??
            TextStyle(
              color: _validDate ? Colors.black : Colors.red,
            ),
        placeHolder: widget.expirationDateFormPlaceholder ?? "MM/AA",
        inputTextAlign: TextAlign.center,
        placeholderStyle: widget.expirationDateFormPlaceholderStyle ??
            const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
        onPress: rotation == 0 ? () {} : () => _onEndAnimation(),
        onTextChange: (text) {
          setState(
            () {
              if (_cardDateController.text.length != 2) {
                _drawDiagonal = _cardDateController.text.length < 2;
              } else if (_cardDateController.text.length == 2 &&
                  _drawDiagonal) {
                _cardDateController.text += "/";
                _cardDateController.selection = TextSelection.fromPosition(
                  TextPosition(
                    offset: _cardDateController.text.length,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Container cardNumberField() {
    return Container(
      width: widget.formWidth ?? 200,
      decoration: widget.cardNumberFieldDecoration ??
          BoxDecoration(
            border: Border.all(
              color: _validCardNumber ? Colors.black : Colors.red,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
      child: ItemDataFormComponent.text(
        controller: _cardNumberController,
        placeHolder: widget.cardNumberFieldPlaceholder ?? "---- ---- ---- ----",
        inputTextAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textStyle: widget.cardNumberFieldTextStyle ??
            TextStyle(
              color: _validCardNumber ? Colors.black : Colors.red,
            ),
        onPress: rotation == 0 ? () {} : () => _onEndAnimation(),
        onTextChange: (text) {
          setState(() {
            String aux =
                _cardNumberController.text.replaceAll(RegExp('\\s+'), "");
            if (aux.length % 4 != 0) {
              _printSpace = aux.length % 4 == 3;
            } else if (aux.length % 4 == 0 && _printSpace) {
              _cardNumberController.text += " ";
              _cardNumberController.selection = TextSelection.fromPosition(
                TextPosition(
                  offset: _cardNumberController.text.length,
                ),
              );
            }
          });
        },
        placeholderStyle: widget.cardNumberFieldPlaceholderStyle ??
            const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
      ),
    );
  }

  Container paymentMethodDropdown() {
    return Container(
      width: widget.formWidth ?? 200,
      decoration: widget.paymentMethodDropdownDecoration ??
          BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
      child: ItemDataFormComponent.dropDown(
        items: paymentMethodNames,
        dropdownPadding: const EdgeInsets.only(left: 10),
        placeHolder:
            widget.paymentMethodDropdownPlaceholderText ?? "Método de pago",
        placeholderDropdownItemColor:
            widget.paymentMethodDropdownPlaceholderTextColor ?? Colors.grey,
        dropdownItemColor:
            widget.paymentMethodDropdownTextColor ?? Colors.black,
        selectedItem: _paymentMethodSelectedItem,
        onChange: (value) {
          if (rotation != 0) {
            _onEndAnimation();
          }
          for (MercadoPagoPaymentMethodModel pm in paymentMethods!) {
            if (value == pm.name!) {
              _currentPaymentMethod = pm;
            }
          }
          _paymentMethodSelectedItem = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _sampleCard() {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(rotation / 180 * pi),
      alignment: Alignment.center,
      child: isFront
          ? Container(
              width: widget.cardWidth ?? 324,
              height: widget.cardHeight ?? 204,
              decoration: widget.cardFrontDecoration ??
                  BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blueGrey,
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        spreadRadius: .5,
                      ),
                    ],
                    gradient: const RadialGradient(
                      colors: [
                        Colors.blue,
                        Colors.cyan,
                        Colors.blue,
                        Colors.cyan,
                        Colors.blue
                      ],
                      stops: [
                        0.66,
                        0.67,
                        0.7,
                        0.72,
                        0.74,
                      ],
                      radius: 2,
                      center: Alignment.topLeft,
                    ),
                  ),
              child: Stack(
                children: [
                  if (_currentPaymentMethod != null) ...[
                    Positioned(
                      bottom: 5,
                      right: 15,
                      child: SizedBox(
                        height: 40,
                        child: Image.network(
                          _currentPaymentMethod!.secureThumbnail!,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 70,
                      left: 20,
                      child: Text(
                        _cardNumberController.text.isNotEmpty
                            ? _getObscuredCardNumber()
                            : "",
                        style: widget.cardTextStyle,
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 20,
                      child: Text(
                        _cardNameController.text,
                        style: widget.cardTextStyle,
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Text(
                        _cardDateController.text,
                        style: widget.cardTextStyle,
                      ),
                    ),
                  ],
                ],
              ),
            )
          : Transform(
              transform: Matrix4.identity()..rotateY(pi),
              alignment: Alignment.center,
              child: Container(
                width: widget.cardWidth ?? 324,
                height: widget.cardHeight ?? 204,
                decoration: widget.cardBackDecoration ??
                    BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blueGrey,
                          offset: Offset(2, 2),
                          blurRadius: 5,
                          spreadRadius: .5,
                        ),
                      ],
                      gradient: const RadialGradient(
                        colors: [
                          Colors.blue,
                          Colors.cyan,
                          Colors.blue,
                          Colors.cyan,
                          Colors.blue
                        ],
                        stops: [
                          0.66,
                          0.67,
                          0.7,
                          0.72,
                          0.74,
                        ],
                        radius: 2,
                        center: Alignment.topRight,
                      ),
                    ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      child: Container(
                        color: Colors.black,
                        width: 324,
                        height: 40,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 90,
                      child: Container(
                        color: Colors.white70,
                        width: 200,
                        height: 30,
                        child: Container(
                          alignment: const Alignment(.7, 0),
                          child: Text(
                            _getObscuredCVV(),
                            style: widget.cardTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  _errorContent() {
    return const Text("ERROR");
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

  _getPaymentMethodsNDNITypes() async {
    paymentMethods = await MercadoPagoManager()
            .getMPPaymentMethods(widget.mtpclient.mercadoPagoCredentials!) ??
        [];
    idTypes = await MercadoPagoManager()
            .getMPIdTypes(widget.mtpclient.mercadoPagoCredentials!) ??
        [];

    for (MercadoPagoPaymentMethodModel paymentMethod in paymentMethods!) {
      paymentMethodNames.add(paymentMethod.name ?? "");
    }
    for (MercadoPagoIdentificationTypeModel idType in idTypes) {
      idNames.add(idType.name ?? "");
    }
  }

  Future<String?> mpGetCardId(
    BuildContext context, {
    required MercadoPagoClientCredentials client,
    required String securityCode,
    required String cardNumber,
    required String expirationYear,
    required String expirationMonth,
    required String name,
    required String dniNumber,
    required MercadoPagoIdentificationTypeModel dniType,
    required MercadoPagoPaymentMethodModel paymentMethod,
  }) async {
    String outStr = "";

    DateTime expDate = DateTime.parse("$expirationYear${expirationMonth}01");
    _validDate = expDate.isAfter(DateTime.now());
    _validName = name.isNotEmpty;
    _validDNI = dniNumber.length >= dniType.minLength! &&
        dniNumber.length <= dniType.maxLength!;

    _validCardNumber = false;
    _validCVV = false;
    for (MercadoPagoPaymentMethodSettingsModel? settings
        in paymentMethod.settings!) {
      if (settings!.securityCode!.mode! == "mandatory" &&
          securityCode.length != settings.securityCode!.length!) break;
      _validCVV = true;
      if (cardNumber.length != settings.cardNumber!.length!) break;
      if (cardNumber.startsWith(RegExp(settings.bin!.pattern!))) {
        _validCardNumber = true;
        break;
      }
    }

    if (!_validCVV ||
        !_validCardNumber ||
        !_validDNI ||
        !_validDate ||
        !_validName) {
      setState(() {});

      return "";
    }

    await LoadingPopup(
      context: context,
      onLoading: _cardIdCall(
        client,
        securityCode,
        cardNumber,
        expirationYear,
        expirationMonth,
        name,
        dniNumber,
        dniType,
        paymentMethod,
      ),
      onResult: (value) {
        outStr = value;
      },
    ).show();
    return outStr;
  }

  _getObscuredCardNumber() {
    String outStr = "";

    for (int i = 0; i < _cardNumberController.text.length; i++) {
      if (i < 4) {
        outStr += _cardNumberController.text[i];
      } else {
        if (_cardNumberController.text[i] == " ") {
          outStr += " ";
        } else {
          outStr += "*";
        }
      }
    }

    return outStr;
  }

  _getObscuredCVV() {
    String outStr = "";

    for (int i = 0; i < _cardCVVController.text.length; i++) {
      outStr += "*";
    }

    return outStr;
  }

  _onEndAnimation() {
    returnAnimation =
        Tween<double>(begin: rotation, end: 0).animate(returnController)
          ..addListener(
            () {
              setState(
                () {
                  rotation = returnAnimation.value;
                  _setSide();
                },
              );
            },
          );
    returnController.forward();
  }

  _onRotate() {
    animation = Tween<double>(begin: rotation, end: 180).animate(controller)
      ..addListener(
        () {
          setState(
            () {
              rotation = animation.value;
              _setSide();
            },
          );
        },
      );
    controller.forward();
  }

  _setSide() => isFront = (rotation <= 90 || rotation >= 270);
}

_cardIdCall(
  client,
  securityCode,
  cardNumber,
  expirationYear,
  expirationMonth,
  name,
  dniNumber,
  dniType,
  paymentMethod,
) async {
  return await MercadoPagoManager().generateCardToken(
    client.publicKey!,
    MercadoPagoCardModel(
      securityCode: securityCode,
      cardNumber: cardNumber,
      expirationYear: expirationYear,
      expirationMonth: expirationMonth,
      cardHolder: MercadoPagoCardHolderModel(
        name: name,
        identification: MercadoPagoIdentificationModel(
          identificationNumber: dniNumber,
          identificationType: dniType,
        ),
      ),
    ),
    paymentMethod,
  );
}
