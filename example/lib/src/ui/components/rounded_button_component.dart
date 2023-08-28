// Flutter imports:
import 'package:flutter/material.dart';

import '../../../values/k_colors.dart';
import '../../../values/k_values.dart';

class RoundedButtonComponent extends StatefulWidget {
  const RoundedButtonComponent({
    Key? key,
    //Texto
    this.text,
    this.fontSize = kFontSize40,
    this.fontWeight = kFontWeightRegular,
    //Icono
    this.icon,
    this.iconWidth = double.infinity,
    this.iconHeight = 20,
    //altura y ancho del boton
    this.height = 60,
    this.width = 100,
    //el radio del borde, borde curvado
    this.borderRadius = 20,
    this.backgroundColor = kPrimary,
    this.borderColor = kPrimary,
    this.textColor = kWhite,
    //Al deshabilitar el botón, tengo colores grisaceos en el background, borde, texto y el shadow
    this.disableBackgroundColor = const Color(0xFFF5F5F5),
    this.disableBorderColor = const Color(0xFFF5F5F5),
    this.disableTextColor = const Color(0xFFC4C4C4),
    this.disableShadowColor = const Color(0x40666666),
    //Habilitado?
    this.isEnabled = true,
    this.hasShadow = false,
    //Algun rich text
    this.richText,
    this.borderWidth = 1,
    //función al presionar
    required this.onPressed,
  }) : super(key: key); //por qué?

  final String? text; //el texto puede ser nulo
  final double fontSize;
  final FontWeight fontWeight;
  final Widget? icon; //el icono puede ser nulo
  final double height;
  final double width;
  final double iconWidth;
  final double iconHeight;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color disableBackgroundColor;
  final Color disableBorderColor;
  final Color disableTextColor;
  final Color disableShadowColor;
  final double borderRadius;
  final double borderWidth;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool hasShadow;
  final RichText? richText; //el richtext puede ser nulo

  @override
  RoundedButtonComponentState createState() =>
      RoundedButtonComponentState(); //create state?-->estado del stateful
}

class RoundedButtonComponentState extends State<RoundedButtonComponent> {
  //stateful
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isEnabled ? widget.onPressed : () {},
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.zero, //por qué cero?
        decoration: BoxDecoration(
          color: widget.isEnabled
              ? widget.backgroundColor
              : widget.disableBackgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            width: widget.borderWidth,
            color: widget.isEnabled
                ? widget.borderColor
                : widget.disableBorderColor,
          ),
          boxShadow: [
            BoxShadow(
              //if anidado
              color: widget.hasShadow
                  ? (!widget.isEnabled //if not true=== if false
                      ? widget.backgroundColor.withOpacity(0.1)
                      : widget.disableShadowColor)
                  : Colors.transparent,
              spreadRadius: 1, //ver
              blurRadius: 1, //ver
              offset: const Offset(0, 1), //ver
            ),
          ],
        ),
        child: Center(
          child: _content(),
        ),
      ),
    );
  }

  _content() {
    if (widget.icon != null &&
        ((widget.text != null && widget.text!.isNotEmpty) ||
            widget.richText != null)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.icon!,
          const SizedBox(width: 10),
          widget.richText ??
              Text(
                widget.text != null && widget.text!.isNotEmpty
                    ? widget.text!
                    : "",
                style: TextStyle(
                  color: widget.isEnabled
                      ? widget.textColor
                      : widget.disableTextColor,
                  fontSize: widget.fontSize,
                ),
              )
        ],
      );
    } else if (widget.icon == null &&
        (widget.text != null && widget.text!.isNotEmpty)) {
      return widget.richText ??
          Text(
            widget.text != null && widget.text!.isNotEmpty ? widget.text! : "",
            style: TextStyle(
              color:
                  widget.isEnabled ? widget.textColor : widget.disableTextColor,
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
            ),
          );
    } else if (widget.icon != null) {
      return widget.icon;
    }
    return const SizedBox.shrink();
  }
}
