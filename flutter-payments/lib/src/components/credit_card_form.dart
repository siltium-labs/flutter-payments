import 'package:flutter/material.dart';

import 'credit_card_model.dart';
import 'credit_card_widget.dart';
//import 'flutter_credit_card.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({
    Key? key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.documentType,
    required this.documentNumber,
    this.obscureCvv = false,
    this.obscureNumber = false,
    required this.onCreditCardModelChange,
    required this.themeColor,
    this.textColor = Colors.black,
    this.cursorColor,
    this.cardHolderDecoration = const InputDecoration(
      labelText: 'Card holder',
    ),
    this.cardNumberDecoration = const InputDecoration(
      labelText: 'Card number',
      hintText: 'XXXX XXXX XXXX XXXX',
    ),
    this.expiryDateDecoration = const InputDecoration(
      labelText: 'Expired Date',
      hintText: 'MM/YY',
    ),
    this.cvvCodeDecoration = const InputDecoration(
      labelText: 'CVV',
      hintText: 'XXX',
    ),
    this.documentTypeDecoration = const InputDecoration(
      labelText: 'Document Type',
    ),
    this.documentNumberDecoration = const InputDecoration(
      labelText: 'Document Number',
    ),
    required this.formKey,
    this.cardNumberKey,
    this.cardHolderKey,
    this.expiryDateKey,
    this.cvvCodeKey,
    this.documentTypeKey,
    this.documentNumberKey,
    this.cvvValidationMessage = 'Please input a valid CVV',
    this.dateValidationMessage = 'Please input a valid date',
    this.numberValidationMessage = 'Please input a valid number',
    this.documentTypeValidationMessage = 'Please input a document type',
    this.documentNumberValidationMessage = 'Please input a document number',
    this.isHolderNameVisible = true,
    this.isCardNumberVisible = true,
    this.isExpiryDateVisible = true,
    this.enableCvv = true,
    this.autovalidateMode,
    this.cardNumberValidator,
    this.expiryDateValidator,
    this.cvvValidator,
    this.cardHolderValidator,
    this.documentTypeValidator,
    this.documentNumberValidator,
    this.onFormComplete,
    this.disableCardNumberAutoFillHints = false,
  }) : super(key: key);

  /// A string indicating card number in the text field.
  final String cardNumber;

  /// A string indicating expiry date in the text field.
  final String expiryDate;

  /// A string indicating card holder name in the text field.
  final String cardHolderName;

  /// A string indicating cvv code in the text field.
  final String cvvCode;

  /// A string indicating docuemnt type in the text field.
  final String documentType;

  /// A string indicating docuemnt number in the text field.
  final String documentNumber;

  /// Error message string when invalid cvv is entered.
  final String cvvValidationMessage;

  /// Error message string when invalid expiry date is entered.
  final String dateValidationMessage;

  /// Error message string when invalid credit card number is entered.
  final String numberValidationMessage;

  /// Error message string when invalid document type is entered.
  final String documentTypeValidationMessage;

  /// Error message string when invalid document number is entered.
  final String documentNumberValidationMessage;

  /// Provides callback when there is any change in [CreditCardModel].
  final void Function(CreditCardModel) onCreditCardModelChange;

  /// Color of the theme of the credit card form.
  final Color themeColor;

  /// Color of text in the credit card form.
  final Color textColor;

  /// Cursor color in the credit card form.
  final Color? cursorColor;

  /// When enabled cvv gets hidden with obscuring characters. Defaults to
  /// false.
  final bool obscureCvv;

  /// When enabled credit card number get hidden with obscuring characters.
  /// Defaults to false.
  final bool obscureNumber;

  /// Allow editing the holder name by enabling this in the credit card form.
  /// Defaults to true.
  final bool isHolderNameVisible;

  /// Allow editing the credit card number by enabling this in the credit
  /// card form. Defaults to true.
  final bool isCardNumberVisible;

  /// Allow editing the cvv code by enabling this in the credit card form.
  /// Defaults to true.
  final bool enableCvv;

  /// Allows editing the expiry date by enabling this in the credit
  /// card form. Defaults to true.
  final bool isExpiryDateVisible;

  /// A form state key for this credit card form.
  final GlobalKey<FormState> formKey;

  /// Provides a callback when text field provides callback in
  /// [onEditingComplete].
  final Function? onFormComplete;

  /// A FormFieldState key for card number text field.
  final GlobalKey<FormFieldState<String>>? cardNumberKey;

  /// A FormFieldState key for card holder text field.
  final GlobalKey<FormFieldState<String>>? cardHolderKey;

  /// A FormFieldState key for expiry date text field.
  final GlobalKey<FormFieldState<String>>? expiryDateKey;

  /// A FormFieldState key for cvv code text field.
  final GlobalKey<FormFieldState<String>>? cvvCodeKey;

  /// A FormFieldState key for document type text field.
  final GlobalKey<FormFieldState<String>>? documentTypeKey;

  /// A FormFieldState key for document number text field.
  final GlobalKey<FormFieldState<String>>? documentNumberKey;

  /// Provides decoration to card number text field.
  final InputDecoration cardNumberDecoration;

  /// Provides decoration to card holder text field.
  final InputDecoration cardHolderDecoration;

  /// Provides decoration to expiry date text field.
  final InputDecoration expiryDateDecoration;

  /// Provides decoration to cvv code text field.
  final InputDecoration cvvCodeDecoration;

  /// Provides decoration to document type text field.
  final InputDecoration documentTypeDecoration;

  /// Provides decoration to document number text field.
  final InputDecoration documentNumberDecoration;

  /// Used to configure the auto validation of [FormField] and [Form] widgets.
  final AutovalidateMode? autovalidateMode;

  /// A validator for card number text field.
  final String? Function(String?)? cardNumberValidator;

  /// A validator for expiry date text field.
  final String? Function(String?)? expiryDateValidator;

  /// A validator for cvv code text field.
  final String? Function(String?)? cvvValidator;

  /// A validator for card holder text field.
  final String? Function(String?)? cardHolderValidator;

  /// A validator for document type text field.
  final String? Function(String?)? documentTypeValidator;

  /// A validator for document number text field.
  final String? Function(String?)? documentNumberValidator;

  /// Setting this flag to true will disable autofill hints for Credit card
  /// number text field. Flutter has a bug when auto fill hints are enabled for
  /// credit card numbers it shows keyboard with characters. But, disabling
  /// auto fill hints will show correct keyboard.
  ///
  /// Defaults to false.
  ///
  /// You can follow the issue here
  /// [https://github.com/flutter/flutter/issues/104604](https://github.com/flutter/flutter/issues/104604).
  final bool disableCardNumberAutoFillHints;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  late String cardNumber;
  late String expiryDate;
  late String cardHolderName;
  late String cvvCode;
  late String documentType;
  late String documentNumber;
  bool isCvvFocused = false;
  //late Color themeColor;

  late void Function(CreditCardModel) onCreditCardModelChange;
  late CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');
  final TextEditingController _documentTypeController = TextEditingController();
  final TextEditingController _documentNumberController =
      TextEditingController();

  FocusNode cvvFocusNode = FocusNode();
  FocusNode expiryDateNode = FocusNode();
  FocusNode cardHolderNode = FocusNode();
  FocusNode documentTypeNode = FocusNode();
  FocusNode documentNumberNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber;
    expiryDate = widget.expiryDate;
    cardHolderName = widget.cardHolderName;
    cvvCode = widget.cvvCode;
    documentType = widget.documentType;
    documentNumber = widget.documentNumber;

    creditCardModel = CreditCardModel(
      cardNumber,
      expiryDate,
      cardHolderName,
      cvvCode,
      isCvvFocused,
      documentType,
      documentNumber,
    );
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    _cardNumberController.text = widget.cardNumber;
    _expiryDateController.text = widget.expiryDate;
    _cardHolderNameController.text = widget.cardHolderName;
    _cvvCodeController.text = widget.cvvCode;

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);
  }

  @override
  void dispose() {
    cardHolderNode.dispose();
    cvvFocusNode.dispose();
    expiryDateNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /* Color _makeColorLighter(Color color, {double factor = 0.1}) {
    int red = (color.red + (255 - color.red) * factor).round().clamp(0, 255);
    int green =
        (color.green + (255 - color.green) * factor).round().clamp(0, 255);
    int blue = (color.blue + (255 - color.blue) * factor).round().clamp(0, 255);

    return Color.fromARGB(color.alpha, red, green, blue);
  } */

  Color _makeColorLighter(
    Color color, {
    double factor = 0.1,
    Color? mixColor,
    double mixFactor = 0.5,
    bool mix = false,
  }) {
    Color mixColors(Color color1, Color color2, double mixFactor) {
      int red = ((color1.red * (1 - mixFactor)) + (color2.red * mixFactor))
          .round()
          .clamp(0, 255);
      int green =
          ((color1.green * (1 - mixFactor)) + (color2.green * mixFactor))
              .round()
              .clamp(0, 255);
      int blue = ((color1.blue * (1 - mixFactor)) + (color2.blue * mixFactor))
          .round()
          .clamp(0, 255);

      return Color.fromARGB(255, red, green, blue);
    }

    int red = (color.red + (255 - color.red) * factor).round().clamp(0, 255);
    int green =
        (color.green + (255 - color.green) * factor).round().clamp(0, 255);
    int blue = (color.blue + (255 - color.blue) * factor).round().clamp(0, 255);

    Color finalColor = Color.fromARGB(color.alpha, red, green, blue);

    if (mix && mixColor != null) {
      finalColor = mixColors(finalColor, mixColor, mixFactor);
    }

    return finalColor;
  }

  Widget formContainer({required Widget child}) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: _makeColorLighter(
          widget.themeColor,
          factor: 0.93,
          mix: false,
          mixColor: Colors.black,
          mixFactor: 0.1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: widget.themeColor.withOpacity(0.8),
        primaryColorDark: widget.themeColor,
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Visibility(
              visible: widget.isCardNumberVisible,
              child: formContainer(
                child: TextFormField(
                  key: widget.cardNumberKey,
                  obscureText: widget.obscureNumber,
                  controller: _cardNumberController,
                  onChanged: (String value) {
                    setState(() {
                      cardNumber = _cardNumberController.text;
                      creditCardModel.cardNumber = cardNumber;
                      onCreditCardModelChange(creditCardModel);
                    });
                  },
                  cursorColor: widget.cursorColor ?? widget.themeColor,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(expiryDateNode);
                  },
                  style: TextStyle(
                    color: widget.textColor,
                  ),
                  decoration: widget.cardNumberDecoration,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autofillHints: widget.disableCardNumberAutoFillHints
                      ? null
                      : const <String>[AutofillHints.creditCardNumber],
                  autovalidateMode: widget.autovalidateMode,
                  validator: widget.cardNumberValidator ??
                      (String? value) {
                        // Validate less that 13 digits +3 white spaces
                        if (value!.isEmpty || value.length < 16) {
                          return widget.numberValidationMessage;
                        }
                        return null;
                      },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Visibility(
                  visible: widget.isExpiryDateVisible,
                  child: Expanded(
                    child: formContainer(
                      child: TextFormField(
                        key: widget.expiryDateKey,
                        controller: _expiryDateController,
                        onChanged: (String value) {
                          if (_expiryDateController.text
                              .startsWith(RegExp('[2-9]'))) {
                            _expiryDateController.text =
                                '0${_expiryDateController.text}';
                          }
                          setState(() {
                            expiryDate = _expiryDateController.text;
                            creditCardModel.expiryDate = expiryDate;
                            onCreditCardModelChange(creditCardModel);
                          });
                        },
                        cursorColor: widget.cursorColor ?? widget.themeColor,
                        focusNode: expiryDateNode,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(cvvFocusNode);
                        },
                        style: TextStyle(
                          color: widget.textColor,
                        ),
                        decoration: widget.expiryDateDecoration,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autofillHints: const <String>[
                          AutofillHints.creditCardExpirationDate
                        ],
                        validator: widget.expiryDateValidator ??
                            (String? value) {
                              if (value!.isEmpty) {
                                return widget.dateValidationMessage;
                              }
                              final DateTime now = DateTime.now();
                              final List<String> date =
                                  value.split(RegExp(r'/'));
                              final int month = int.parse(date.first);
                              final int year = int.parse('20${date.last}');
                              final int lastDayOfMonth = month < 12
                                  ? DateTime(year, month + 1, 0).day
                                  : DateTime(year + 1, 1, 0).day;
                              final DateTime cardDate = DateTime(
                                  year, month, lastDayOfMonth, 23, 59, 59, 999);

                              if (cardDate.isBefore(now) ||
                                  month > 12 ||
                                  month == 0) {
                                return widget.dateValidationMessage;
                              }
                              return null;
                            },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Visibility(
                    visible: widget.enableCvv,
                    child: formContainer(
                      child: TextFormField(
                        key: widget.cvvCodeKey,
                        obscureText: widget.obscureCvv,
                        focusNode: cvvFocusNode,
                        controller: _cvvCodeController,
                        cursorColor: widget.cursorColor ?? widget.themeColor,
                        onEditingComplete: () {
                          if (widget.isHolderNameVisible) {
                            FocusScope.of(context).requestFocus(cardHolderNode);
                          } else {
                            FocusScope.of(context)
                                .requestFocus(documentTypeNode);
                          }
                        },
                        style: TextStyle(
                          color: widget.textColor,
                        ),
                        decoration: widget.cvvCodeDecoration,
                        keyboardType: TextInputType.number,
                        textInputAction: widget.isHolderNameVisible
                            ? TextInputAction.next
                            : TextInputAction.done,
                        autofillHints: const <String>[
                          AutofillHints.creditCardSecurityCode
                        ],
                        onChanged: (String text) {
                          setState(() {
                            cvvCode = text;
                            creditCardModel.cvvCode = cvvCode;
                            onCreditCardModelChange(creditCardModel);
                          });
                        },
                        validator: widget.cvvValidator ??
                            (String? value) {
                              if (value!.isEmpty || value.length < 3) {
                                return widget.cvvValidationMessage;
                              }
                              return null;
                            },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: widget.isHolderNameVisible,
              child: formContainer(
                child: TextFormField(
                  key: widget.cardHolderKey,
                  controller: _cardHolderNameController,
                  onChanged: (String value) {
                    setState(() {
                      cardHolderName = _cardHolderNameController.text;
                      creditCardModel.cardHolderName = cardHolderName;
                      onCreditCardModelChange(creditCardModel);
                    });
                  },
                  cursorColor: widget.cursorColor ?? widget.themeColor,
                  focusNode: cardHolderNode,
                  style: TextStyle(
                    color: widget.textColor,
                  ),
                  decoration: widget.cardHolderDecoration,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofillHints: const <String>[AutofillHints.creditCardName],
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(documentTypeNode);
                  },
                  validator: widget.cardHolderValidator,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Visibility(
                  visible: true,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: formContainer(
                        child: TextFormField(
                          key: widget.documentTypeKey,
                          controller: _documentTypeController,
                          onChanged: (String value) {
                            setState(() {
                              documentType = _documentTypeController.text;
                              creditCardModel.documentType = documentType;
                              onCreditCardModelChange(creditCardModel);
                            });
                          },
                          cursorColor: widget.cursorColor ?? widget.themeColor,
                          focusNode: documentTypeNode,
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(documentNumberNode);
                          },
                          style: TextStyle(
                            color: widget.textColor,
                          ),
                          decoration: widget.documentTypeDecoration,
                          //keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          autofillHints: const <String>[],
                          validator: widget.documentTypeValidator ??
                              (String? value) {
                                if (value!.isEmpty) {
                                  return widget.documentTypeValidationMessage;
                                }
                                return null;
                              },
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: true,
                  child: Expanded(
                    flex: 2,
                    child: formContainer(
                      child: TextFormField(
                        key: widget.documentNumberKey,
                        obscureText: false,
                        focusNode: documentNumberNode,
                        controller: _documentNumberController,
                        cursorColor: widget.cursorColor ?? widget.themeColor,
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          onCreditCardModelChange(creditCardModel);
                          widget.onFormComplete?.call();
                        },
                        style: TextStyle(
                          color: widget.textColor,
                        ),
                        decoration: widget.documentNumberDecoration,
                        //keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        autofillHints: const <String>[],
                        onChanged: (String text) {
                          setState(() {
                            documentNumber = text;
                            creditCardModel.documentNumber = documentNumber;
                            onCreditCardModelChange(creditCardModel);
                          });
                        },
                        validator: widget.documentNumberValidator ??
                            (String? value) {
                              if (value!.isEmpty) {
                                return widget.documentNumberValidationMessage;
                              }
                              return null;
                            },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
