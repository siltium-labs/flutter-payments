import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ItemDataFormType {
  text,
  number,
  dropDown,
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

  //TEXT
  TextEditingController? controller;
  Function(String)? onTextChange;
  TextInputType textInputType = TextInputType.text;
  TextInputAction? textInputAction;
  Function()? onPress;
  Color errorBorderColor = Colors.transparent;
  Color borderColor = Colors.transparent;
  TextStyle? errorTextStyle;
  BorderRadius? borderRadius;
  EdgeInsets? innerPadding;
  double? height;
  Alignment? alignment;
  BoxBorder? errorBorder;
  Widget? leftIcon;
  Widget? rightIcon;
  TextAlign? inputTextAlign;
  bool isPassword = false;
  bool isRequired = false;
  bool isEnabled = true;
  ValidateFunction? validate;
  int? maxLength;
  TextInputType? keyboardType;
  VoidCallback? onEditComplete;
  EdgeInsets? scrollPadding;
  bool isPasswordEnabled = true;
  TextStyle? textStyle;
  String passwordEnablerText = "Mostrar";
  FocusNode? focusNode;
  String? placeholder;
  List<TextInputFormatter> inputFormatters = [];
  int? maxLines;
  int? minLines;

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
  Color? errorPlaceHolderColor;
  double? errorPlaceHolderSize;
  Color? validColor;
  Color? invalidColor;
  double? validateFontSize;
  Color? validInputTextColor;
  double? inputTextSize;
  Color? invalidInputTextColor;
  Color? dividerLineValidColor;
  Color? dividerLineInvalidColor;
  Color? focusBorderValidColor;
  Color? focusBorderInvalidColor;
  Color? hintTextColor;
  double? hintTextSize;
  double? passwordEnablerFontSize;
  Color? passwordEnablerColor;
  late List<dynamic> items;
  late dynamic selectedItem;
  late Function onChange;
  Color? dropdownItemColor;
  double? dropdownItemSize;
  Color? placeholderDropdownItemColor;
  double? placeholderDropdownItemSize;
  EdgeInsets? dropdownPadding;

  ItemDataFormComponent.text({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.errorBorderColor = Colors.transparent,
    this.borderColor = Colors.transparent,
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
    this.errorBorder,
    this.errorTextStyle,
    this.leftIcon,
    this.rightIcon,
    this.inputTextAlign,
    this.isRequired = false,
    this.isPassword = false,
    this.isEnabled = true,
    this.validate,
    this.maxLength,
    this.keyboardType,
    this.onEditComplete,
    this.scrollPadding,
    this.textInputAction = TextInputAction.done,
    this.errorMessage = "",
    this.onTextChange,
    this.textStyle,
    this.onPress,
    this.inputFormatters = const [],
    this.showErrorPlaceHolder = true,
    this.errorPlaceHolder = "",
    this.maxLines = 1,
    this.minLines = 1,
    this.errorPlaceHolderColor,
    this.errorPlaceHolderSize,
    this.validColor,
    this.invalidColor,
    this.validateFontSize,
    this.validInputTextColor,
    this.inputTextSize,
    this.invalidInputTextColor,
    this.dividerLineValidColor,
    this.focusBorderValidColor,
    this.focusBorderInvalidColor,
    this.hintTextColor,
    this.hintTextSize,
    this.passwordEnablerFontSize,
    this.passwordEnablerColor,
  }) : super(key: key) {
    type = ItemDataFormType.text;
  }

  ItemDataFormComponent.number({
    Key? key,
    this.isValid = true,
    this.label = '',
    this.errorMessage,
    this.errorBorderColor = Colors.transparent,
    this.onTextChange,
    required this.controller,
    this.placeholder,
    this.backgroundColor = Colors.white,
    this.hasDividerLine = false,
    this.boxShadow,
    this.placeholderStyle,
    this.innerPadding,
    this.borderRadius,
    this.textStyle,
    this.height,
    this.alignment,
    this.errorBorder,
    this.errorTextStyle,
    this.leftIcon,
    this.rightIcon,
    this.inputTextAlign,
    this.isRequired = false,
    this.isPassword = false,
    this.validate,
    this.maxLength,
    this.onEditComplete,
    this.focusNode,
    this.textInputAction,
    this.onPress,
    this.showErrorPlaceHolder = true,
    this.errorPlaceHolder = "",
    this.errorPlaceHolderColor,
    this.errorPlaceHolderSize,
    this.validColor,
    this.invalidColor,
    this.validateFontSize,
    this.validInputTextColor,
    this.inputTextSize,
    this.invalidInputTextColor,
    this.dividerLineValidColor,
    this.focusBorderValidColor,
    this.focusBorderInvalidColor,
    this.hintTextColor,
    this.hintTextSize,
    this.passwordEnablerFontSize,
    this.passwordEnablerColor,
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
    this.dropdownItemColor,
    this.dropdownItemSize,
    this.placeholderDropdownItemColor,
    this.placeholderDropdownItemSize,
    this.dropdownPadding,
  }) : super(key: key) {
    type = ItemDataFormType.dropDown;
  }

  @override
  _ItemDataFormComponentState createState() => _ItemDataFormComponentState();
}

class _ItemDataFormComponentState extends State<ItemDataFormComponent> {
  bool isValid = true;
  String textError = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.label.isNotEmpty,
          child: const SizedBox(
            height: 15,
          ),
        ),
        _label(),
        const SizedBox(
          height: 5,
        ),
        _content(),
        Visibility(
          visible: !widget.isValid && widget.showErrorPlaceHolder,
          child: Text(
            widget.errorPlaceHolder.isEmpty
                ? "Este campo es requerido"
                : widget.errorPlaceHolder,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: widget.errorPlaceHolderColor,
              fontSize: widget.errorPlaceHolderSize,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  _label() {
    return Visibility(
      visible: widget.label.isNotEmpty,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.label,
          softWrap: true,
          style: TextStyle(
            color: widget.isValid ? widget.validColor : widget.invalidColor,
            fontWeight: widget.isValid ? FontWeight.normal : FontWeight.bold,
            fontSize: widget.validateFontSize,
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
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
        border: Border.all(
          color: widget.isValid ? widget.borderColor : widget.errorBorderColor,
        ),
      ),
      height: widget.height,
      alignment: widget.alignment,
      child: Padding(
        padding: widget.innerPadding ?? EdgeInsets.zero,
        child: Row(
          children: [
            widget.leftIcon ?? const SizedBox.shrink(),
            Expanded(
              child: TextField(
                onTap: widget.onPress,
                enabled: widget.isEnabled,
                keyboardType: widget.keyboardType,
                onEditingComplete: widget.onEditComplete,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.maxLength),
                  ...widget.inputFormatters
                ],
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                textInputAction: widget.textInputAction,
                scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(0),
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
                style: widget.isValid
                    ? widget.textStyle ??
                        TextStyle(
                          color: widget.validInputTextColor,
                          fontSize: widget.inputTextSize,
                        )
                    : widget.errorTextStyle ??
                        TextStyle(
                          color: widget.invalidInputTextColor,
                          fontSize: widget.inputTextSize,
                        ),
                textAlign: widget.inputTextAlign ?? TextAlign.start,
                decoration: InputDecoration(
                  contentPadding: widget.hasDividerLine
                      ? const EdgeInsets.only(bottom: 13)
                      : null,
                  border: widget.hasDividerLine
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: widget.isValid
                                ? widget.dividerLineValidColor!
                                : widget.dividerLineInvalidColor!,
                          ),
                        )
                      : InputBorder.none,
                  focusedBorder: widget.hasDividerLine
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: widget.isValid
                                ? widget.focusBorderValidColor!
                                : widget.focusBorderInvalidColor!,
                          ),
                        )
                      : InputBorder.none,
                  hintText: widget.placeHolder ?? '',
                  hintStyle: widget.placeholderStyle ??
                      TextStyle(
                        color: widget.hintTextColor,
                        fontSize: widget.hintTextSize,
                      ),
                  isCollapsed: true,
                ),
              ),
            ),
            widget.rightIcon ?? const SizedBox.shrink(),
            Visibility(
              visible: widget.isPassword &&
                  (widget.controller != null
                      ? widget.controller!.text.isNotEmpty
                      : false),
              child: InkWell(
                onTap: () {
                  setState(
                    () {
                      widget.isPasswordEnabled = !widget.isPasswordEnabled;
                      widget.isPasswordEnabled
                          //i18n
                          ? widget.passwordEnablerText = 'Mostrar'
                          : widget.passwordEnablerText = 'Ocultar';
                    },
                  );
                },
                child: _getPasswordEnabler(widget.passwordEnablerText),
              ),
            )
          ],
        ),
      ),
    );
  }

  validate(String? value) {
    setState(
      () {
        String? validatorData =
            widget.validate != null ? widget.validate!(value!) : null;
        textError = validatorData ?? "";
        isValid = (widget.validate == null ||
                validatorData == null ||
                validatorData.isEmpty) &&
            (!widget.isRequired || (widget.isRequired && value!.isNotEmpty));
      },
    );
  }

  _getPasswordEnabler(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Text(
        text,
        style: TextStyle(
          fontSize: widget.passwordEnablerFontSize,
          fontWeight: FontWeight.normal,
          color: widget.passwordEnablerColor,
        ),
      ),
    );
  }

  _number() {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
        border: Border.all(
          color: widget.isValid ? widget.borderColor : widget.errorBorderColor,
        ),
      ),
      height: widget.height,
      alignment: widget.alignment,
      child: Padding(
        padding: widget.innerPadding ?? EdgeInsets.zero,
        child: Row(
          children: [
            widget.leftIcon ?? const SizedBox.shrink(),
            Expanded(
              child: TextFormField(
                onTap: widget.onPress,
                obscureText: widget.isPasswordEnabled && widget.isPassword,
                obscuringCharacter: "*",
                onChanged: (value) {
                  if (widget.onTextChange != null) {
                    widget.onTextChange!(value);
                  }
                },
                onEditingComplete: widget.onEditComplete,
                focusNode: widget.focusNode,
                textInputAction: widget.textInputAction,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.maxLength),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: (value) => validate(value),
                controller: widget.controller,
                cursorColor: Colors.grey,
                style: widget.isValid
                    ? widget.textStyle ??
                        TextStyle(
                          color: widget.validInputTextColor,
                          fontSize: widget.inputTextSize,
                        )
                    : widget.errorTextStyle ??
                        TextStyle(
                          color: widget.invalidInputTextColor,
                          fontSize: widget.inputTextSize,
                        ),
                textAlign: widget.inputTextAlign ?? TextAlign.start,
                decoration: InputDecoration(
                  contentPadding: widget.hasDividerLine
                      ? const EdgeInsets.only(bottom: 13)
                      : null,
                  hintText: widget.placeholder ?? '',
                  hintStyle: widget.placeholderStyle ??
                      TextStyle(
                        color: widget.hintTextColor,
                        fontSize: widget.hintTextSize,
                      ),
                  border: widget.hasDividerLine
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: widget.isValid
                                ? widget.dividerLineValidColor!
                                : widget.dividerLineInvalidColor!,
                          ),
                        )
                      : InputBorder.none,
                  focusedBorder: widget.hasDividerLine
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.5,
                            color: widget.isValid
                                ? widget.focusBorderValidColor!
                                : widget.focusBorderInvalidColor!,
                          ),
                        )
                      : InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),
            widget.rightIcon ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  _dropDown() {
    return DropdownButton(
      onTap: widget.onPress,
      hint: widget.selectedItem == null
          ? Text(
              widget.placeHolder ?? "", //TODO i18n
              style: TextStyle(
                color: widget.placeholderDropdownItemColor,
                fontWeight: FontWeight.normal,
                fontSize: widget.placeholderDropdownItemSize,
              ),
            )
          : null,
      value: widget.selectedItem,
      padding: widget.dropdownPadding,
      isExpanded: true,
      isDense: true,
      style: TextStyle(
        color: widget.dropdownItemColor,
        fontWeight: FontWeight.normal,
        fontSize: widget.dropdownItemSize,
      ),
      underline: const SizedBox.shrink(),
      icon: Icon(
        Icons.keyboard_arrow_down,
        size: 25,
        color: widget.dropdownItemColor,
      ),
      items: widget.items.map(
        (dynamic value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: widget.dropdownItemColor,
                fontWeight: FontWeight.normal,
                fontSize: widget.dropdownItemSize,
              ),
            ),
          );
        },
      ).toList(),
      onChanged: (newValue) {
        setState(() {
          widget.selectedItem = newValue;
          widget.onChange(newValue);
        });
      },
    );
  }
}
