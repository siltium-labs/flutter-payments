// Flutter imports:
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payments/src/utils/extensions.dart';
import '../../values/k_colors.dart';
import '../../values/k_values.dart';

// Package imports:

// Project imports:

enum ItemDataFormType {
  //text,
  text,
  number,
  date,
  dropDown,
}

enum CheckBoxLabelType {
  left,
  right,
}

typedef ValidateFunction = String? Function(String value);

// ignore: must_be_immutable
class ItemDataFormComponent extends StatefulWidget {
  //COMMONS
  late ItemDataFormType type;
  bool isValid;
  String label;
  String? errorMessage;
  late Color backgroundColor;
  bool hasDividerLine;
  String? placeHolder;
  List<BoxShadow>? boxShadow;
  TextStyle? placeholderStyle;
  bool showErrorPlaceHolder;
  String errorPlaceHolder;
  double? minHeight;
  Color? dividerLineColor;
  bool readOnly = false;
  bool showCursor = true;

  //TEXT
  TextEditingController? controller;
  Function(String)? onTextChange;
  Function(String)? onSubmitted;
  TextInputType textInputType = TextInputType.text;
  TextInputAction? textInputAction;
  Function()? onPress;
  TextStyle? errorTextStyle;
  BorderRadius? borderRadius;
  EdgeInsets? innerPadding;
  double? height;
  Alignment? alignment;
  Widget? leftIcon;
  Widget? rightIcon;
  TextAlign? inputTextAlign;
  bool isPassword = false;
  bool isRequired = false;
  bool isEnabled = true;
  ValidateFunction? validate;
  int? maxLength;
  bool showMaxLength = false;
  bool showMaxLengthOutside = false;
  TextInputType? keyboardType;
  VoidCallback? onEditComplete;
  EdgeInsets? scrollPadding;
  bool isPasswordEnabled = false;
  TextStyle? textStyle;
  String passwordEnablerText = 'mostrar';
  FocusNode? focusNode;
  String? placeholder;
  List<TextInputFormatter> inputFormatters = [];
  int? maxLines;
  int? minLines;
  Widget? prefixIcon;
  Border? border;
  Border? errorBorder;
  bool isCollapsed = false;
  bool autofocus = false;
  bool obscureText = false;

  //DROPDOWN
  late List<dynamic> items;
  late dynamic selectedItem;
  late Function(dynamic) onChange;
  bool isExpanded = true;
  Widget? dropdownIcon;
  BoxDecoration? dropdownDecoration;
  List<DropdownMenuItem<Object>>? customItemBuilder;
  int dropdownElevation = 1;
  bool alignedDropdown = true;
  Widget? customDropdownHint;
  double? dropdownButtonWidth;
  double? itemHeight;
  Widget? customDropdownButton;
  Function(bool)? onMenuStateChange;
  String Function(dynamic)? dynamicTextItemBuilder;
  Color? iconColor;

  //IMAGEID
  String? labelImage1;
  String? labelImage2;
  String? imageUrl1;
  String? imageUrl2;
  String? imagePath1;
  String? imagePath2;
  Function()? onImage1Tap;
  Function()? onImage2Tap;
  Function()? onIconTrashTap1;
  Function()? onIconTrashTap2;

  //CHECKBOX
  late bool autoCheckOnClick;
  String? checkBoxLabel;
  Widget? checkBoxWidget;
  CheckBoxLabelType? checkBoxType;
  late bool isSelected;
  String? iconLeftPath;
  Function(bool isCheck)? onTap;

  //SIGNATURE
  late Color colorSignature;
  Function(ByteData?)? onSignatureLoad;

  ItemDataFormComponent.text({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.controller,
    this.placeHolder,
    this.backgroundColor = Colors.white,
    this.hasDividerLine = false,
    this.boxShadow,
    this.placeholderStyle,
    this.innerPadding,
    this.borderRadius,
    this.height,
    this.alignment,
    this.errorTextStyle,
    this.leftIcon,
    this.rightIcon,
    this.inputTextAlign,
    this.isRequired = false,
    this.isPassword = false,
    this.isPasswordEnabled = false,
    this.isEnabled = true,
    this.validate,
    this.maxLength,
    this.showMaxLength = false,
    this.showMaxLengthOutside = false,
    this.keyboardType,
    this.onEditComplete,
    this.scrollPadding,
    this.textInputAction = TextInputAction.done,
    this.errorMessage = "",
    this.onTextChange,
    this.onSubmitted,
    this.textStyle,
    this.onPress,
    this.inputFormatters = const [],
    this.showErrorPlaceHolder = true,
    this.errorPlaceHolder = "",
    this.maxLines = 1,
    this.minLines = 1,
    this.prefixIcon,
    this.border,
    this.errorBorder,
    this.isCollapsed = false,
    this.minHeight,
    this.dividerLineColor,
    this.readOnly = false,
    this.showCursor = true,
    this.focusNode,
  }) : super(key: key) {
    type = ItemDataFormType.text;
  }

  ItemDataFormComponent.number({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.errorMessage,
    this.onTextChange,
    this.onSubmitted,
    required this.controller,
    this.showMaxLength = false,
    this.placeholder,
    this.backgroundColor = Colors.white,
    this.hasDividerLine = false,
    this.boxShadow,
    this.placeholderStyle,
    this.innerPadding,
    this.borderRadius,
    this.height,
    this.alignment,
    this.errorBorder,
    this.border,
    this.errorTextStyle,
    this.leftIcon,
    this.rightIcon,
    this.inputTextAlign,
    this.isRequired = false,
    this.isPassword = false,
    this.isEnabled = true,
    this.validate,
    this.maxLength,
    this.showMaxLengthOutside = false,
    this.onEditComplete,
    this.focusNode,
    this.textInputAction,
    this.onPress,
    this.showErrorPlaceHolder = true,
    this.errorPlaceHolder = "",
    this.isCollapsed = false,
    this.textStyle,
    this.minHeight,
    this.dividerLineColor,
    this.readOnly = false,
    this.inputFormatters = const [],
    this.showCursor = true,
    this.autofocus = false,
    this.obscureText = false,
    this.keyboardType = const TextInputType.numberWithOptions(
      decimal: true,
    ),
  }) : super(key: key) {
    type = ItemDataFormType.number;
  }

  ItemDataFormComponent.dropDown({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.backgroundColor = Colors.white,
    required this.items,
    this.selectedItem,
    required this.onChange,
    this.errorMessage,
    this.placeHolder = '',
    this.onPress,
    this.hasDividerLine = false,
    this.showErrorPlaceHolder = true,
    this.errorPlaceHolder = "",
    this.height,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.textStyle,
    this.placeholder,
    this.placeholderStyle,
    this.innerPadding,
    this.isExpanded = true,
    this.dropdownIcon,
    this.dropdownDecoration,
    this.customItemBuilder,
    this.dropdownElevation = 1,
    this.alignedDropdown = true,
    this.customDropdownHint,
    this.dropdownButtonWidth,
    this.customDropdownButton,
    this.itemHeight,
    this.onMenuStateChange,
    this.dynamicTextItemBuilder,
    this.iconColor,
  }) : super(key: key) {
    type = ItemDataFormType.dropDown;
  }

  @override
  ItemDataFormComponentState createState() => ItemDataFormComponentState();
}

class ItemDataFormComponentState extends State<ItemDataFormComponent> {
  bool isValid = true;
  String textError = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !widget.label.isNullOrEmpty,
          child: const SizedBox(height: 10),
        ),
        _label(),
        if (!widget.label.isNullOrEmpty) const SizedBox(height: 5),
        _content(),
      ],
    );
  }

  _label() {
    return Visibility(
      visible: !widget.label.isNullOrEmpty,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.label,
          softWrap: true,
          style: TextStyle(
            color: widget.isValid ? Colors.grey : Colors.red,
            fontWeight: widget.isValid ? FontWeight.normal : FontWeight.bold,
            fontSize: kFontSize35,
          ),
        ),
      ),
    );
  }

  _content() {
    switch (widget.type) {
      case ItemDataFormType.text:
        return _text();
      case ItemDataFormType.number:
        return _number();
      case ItemDataFormType.dropDown:
        return _dropDown();
      default:
        return _text();
    }
  }

  _text() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: widget.borderRadius,
            boxShadow: widget.boxShadow,
            border: widget.isValid ? widget.border : widget.errorBorder,
          ),
          height: widget.height,
          constraints: widget.minHeight != null
              ? BoxConstraints(minHeight: widget.minHeight!)
              : null,
          alignment: widget.alignment,
          child: Padding(
            padding: widget.innerPadding ?? EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.leftIcon ?? const SizedBox.shrink(),
                Expanded(
                  child: TextField(
                    readOnly: widget.readOnly,
                    showCursor: widget.showCursor,
                    autofocus: false,
                    focusNode: widget.focusNode,
                    onTap: widget.onPress,
                    enabled: widget.isEnabled,
                    keyboardType: widget.keyboardType,
                    onEditingComplete: widget.onEditComplete,
                    textAlignVertical: TextAlignVertical.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(widget.maxLength),
                      ...widget.inputFormatters
                    ],
                    maxLength:
                        widget.showMaxLength && !widget.showMaxLengthOutside
                            ? widget.maxLength
                            : null,
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    textInputAction: widget.textInputAction,
                    scrollPadding: widget.scrollPadding ?? EdgeInsets.zero,
                    //validator: (value) => validate(value),
                    controller: widget.controller,
                    cursorColor: Colors.grey,
                    obscureText: widget.isPasswordEnabled && widget.isPassword,
                    obscuringCharacter: "*",
                    onChanged: (value) {
                      setState(() {});
                      if (widget.onTextChange != null) {
                        widget.onTextChange!(value);
                      }
                    },
                    onSubmitted: (value) {
                      setState(() {});
                      if (widget.onSubmitted != null) {
                        widget.onSubmitted!(value);
                      }
                    },
                    style: widget.isValid
                        ? widget.textStyle ??
                            const TextStyle(
                              color: Colors.grey,
                              fontSize: kFontSize35,
                            )
                        : widget.errorTextStyle ??
                            const TextStyle(
                              color: Colors.red,
                              fontSize: kFontSize35,
                            ),
                    textAlign: widget.inputTextAlign ?? TextAlign.start,

                    decoration: InputDecoration(
                      // contentPadding: widget.hasDividerLine
                      //     ? const EdgeInsets.only(bottom: 13)
                      //     : null,
                      border: widget.hasDividerLine
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.5,
                                color: widget.dividerLineColor ??
                                    (widget.isValid ? kGray : kRed),
                              ),
                            )
                          : InputBorder.none,
                      enabledBorder: widget.hasDividerLine
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.5,
                                color: widget.isValid ? kGray : kRed,
                              ),
                            )
                          : InputBorder.none,
                      focusedBorder: widget.hasDividerLine
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.5,
                                color: widget.isValid ? kGray : kRed,
                              ),
                            )
                          : InputBorder.none,
                      hintText: widget.placeHolder.hasValue()
                          ? widget.placeHolder
                          : '',
                      hintStyle: widget.placeholderStyle ??
                          const TextStyle(
                            color: Colors.grey,
                            fontSize: kFontSize35,
                          ),
                      isCollapsed: widget.isCollapsed,
                      suffixIcon: widget.rightIcon ??
                          Visibility(
                            visible: widget.isPassword &&
                                (widget.controller != null
                                    ? widget.controller!.text.isNotEmpty
                                    : false),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  widget.isPasswordEnabled =
                                      !widget.isPasswordEnabled;
                                  widget.isPasswordEnabled
                                      ? widget.passwordEnablerText = 'mostrar'
                                      : widget.passwordEnablerText = 'ocultar';
                                });
                              },
                              child: _getPasswordEnabler(
                                  widget.passwordEnablerText),
                            ),
                          ),
                      suffixIconConstraints: const BoxConstraints(
                        minHeight: 20,
                      ),
                      prefixIcon: widget.prefixIcon,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!widget.isValid && widget.showErrorPlaceHolder)
          const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Visibility(
                visible: !widget.isValid && widget.showErrorPlaceHolder,
                child: Text(
                  widget.errorPlaceHolder.isEmpty
                      ? 'error'
                      : widget.errorPlaceHolder,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: kFontSize35,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.showMaxLengthOutside,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  "${widget.controller!.text.length}/${widget.maxLength}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: kFontSize30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  validate(String? value) {
    setState(() {
      String? validatorData =
          widget.validate != null ? widget.validate!(value!) : null;
      textError = validatorData ?? "";
      isValid = (widget.validate == null ||
              validatorData == null ||
              validatorData.isEmpty) &&
          (!widget.isRequired || (widget.isRequired && value!.isNotEmpty));
    });
  }

  _getPasswordEnabler(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: kFontSize35,
          fontWeight: FontWeight.normal,
          color: Colors.red,
        ),
      ),
    );
  }

  _number() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: widget.borderRadius,
            boxShadow: widget.boxShadow,
            border: widget.isValid ? widget.border : widget.errorBorder,
          ),
          height: widget.height,
          constraints: widget.minHeight != null
              ? BoxConstraints(minHeight: widget.minHeight!)
              : null,
          alignment: widget.alignment,
          child: Padding(
            padding: widget.innerPadding ?? EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.leftIcon ?? const SizedBox.shrink(),
                Expanded(
                  child: TextFormField(
                    showCursor: widget.showCursor,
                    readOnly: widget.readOnly,
                    autofocus: widget.autofocus,
                    obscureText: widget.obscureText,
                    onTap: widget.onPress,
                    onChanged: (value) {
                      if (widget.onTextChange != null) {
                        widget.onTextChange!(value);
                      }
                    },
                    enabled: widget.isEnabled,
                    onFieldSubmitted: (value) {
                      setState(() {});
                      if (widget.onSubmitted != null) {
                        widget.onSubmitted!(value);
                      }
                    },
                    onEditingComplete: widget.onEditComplete,
                    focusNode: widget.focusNode,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(widget.maxLength),
                      DecimalTextInputFormatter(decimalRange: 2),
                      ...widget.inputFormatters,
                    ],
                    maxLength:
                        widget.showMaxLength && !widget.showMaxLengthOutside
                            ? widget.maxLength
                            : null,
                    keyboardType: widget.keyboardType,
                    validator: (value) => validate(value),
                    controller: widget.controller,
                    cursorColor: Colors.grey,
                    style: widget.isValid
                        ? widget.textStyle ??
                            const TextStyle(
                              color: Colors.grey,
                              fontSize: kFontSize35,
                            )
                        : widget.errorTextStyle ??
                            const TextStyle(
                              color: Colors.red,
                              fontSize: kFontSize35,
                            ),
                    textAlign: widget.inputTextAlign ?? TextAlign.left,
                    decoration: InputDecoration(
                      // contentPadding: widget.hasDividerLine
                      //     ? const EdgeInsets.only(bottom: 13)
                      //     : null,
                      hintText: widget.placeholder.hasValue()
                          ? widget.placeholder
                          : '',
                      hintStyle: widget.placeholderStyle ??
                          const TextStyle(
                            color: Colors.grey,
                            fontSize: kFontSize35,
                          ),
                      border: widget.hasDividerLine
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.5,
                                color: widget.isValid ? kGray : kRed,
                              ),
                            )
                          : InputBorder.none,
                      enabledBorder: widget.hasDividerLine
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.5,
                                color: widget.isValid ? kGray : kRed,
                              ),
                            )
                          : InputBorder.none,
                      focusedBorder: widget.hasDividerLine
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.5,
                                color: widget.isValid ? kGray : kRed,
                              ),
                            )
                          : InputBorder.none,
                      isCollapsed: widget.isCollapsed,
                    ),
                  ),
                ),
                widget.rightIcon ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: Visibility(
              visible: !widget.isValid && widget.showErrorPlaceHolder,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  widget.errorPlaceHolder.isEmpty
                      //i18n
                      ? 'Error'
                      : widget.errorPlaceHolder,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: kFontSize35,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.showMaxLengthOutside,
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "${widget.controller!.text.length}/${widget.maxLength}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: kFontSize30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  _dropDown() {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        padding: EdgeInsets.zero,
        alignedDropdown: widget.alignedDropdown,
        child: DropdownButton2(
          itemHeight: widget.itemHeight ?? kMinInteractiveDimension,
          customButton: widget.customDropdownButton,
          itemPadding: EdgeInsets.zero,
          buttonWidth: widget.dropdownButtonWidth,
          hint: widget.customDropdownHint ??
              Text(
                widget.selectedItem != null
                    ? widget.dynamicTextItemBuilder != null
                        ? widget.dynamicTextItemBuilder!(widget.selectedItem)
                        : widget.selectedItem.toString()
                    : widget.placeHolder ?? "",
                style: widget.selectedItem != null
                    ? widget.textStyle ??
                        const TextStyle(
                          color: kGray,
                          fontWeight: FontWeight.normal,
                          fontSize: kFontSize35,
                        )
                    : widget.placeholderStyle ??
                        const TextStyle(
                          color: kGrayL1,
                          fontWeight: FontWeight.normal,
                          fontSize: kFontSize35,
                        ),
              ),
          isExpanded: widget.isExpanded,
          isDense: true,
          style: widget.textStyle ??
              const TextStyle(
                color: kGray,
                fontWeight: FontWeight.normal,
                fontSize: kFontSize35,
              ),
          underline: const SizedBox.shrink(),
          icon: widget.dropdownIcon ??
              Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: widget.iconColor ?? kGrayL1,
              ),
          onMenuStateChange: widget.onMenuStateChange,
          items: widget.customItemBuilder ??
              widget.items.map(
                (dynamic value) {
                  return DropdownMenuItem<dynamic>(
                    value: value,
                    child: Padding(
                      padding: widget.innerPadding ?? EdgeInsets.zero,
                      child: Text(
                        widget.dynamicTextItemBuilder != null
                            ? widget.dynamicTextItemBuilder!(value)
                            : value.toString(),
                        style: const TextStyle(
                          color: kGray,
                          fontWeight: kFontWeightRegular,
                          fontSize: kFontSize35,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
          onChanged: widget.onChange,
          dropdownDecoration: widget.dropdownDecoration ??
              const BoxDecoration(
                color: kWhiteT1,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
          dropdownElevation: widget.dropdownElevation,
          buttonDecoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: widget.borderRadius,
            border: widget.border,
            boxShadow: widget.boxShadow,
          ),
          buttonPadding: widget.innerPadding,
          alignment: Alignment.centerLeft,
          buttonHeight: widget.height,
          offset: const Offset(0, -2),
        ),
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int? decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange!) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: min(truncated.length, truncated.length + 1),
          extentOffset: min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
