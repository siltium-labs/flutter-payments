import 'package:flutter/material.dart';
import '/src/utils/extensions.dart';
import '/values/k_colors.dart';
import '/values/k_values.dart';

class InformationAlertPopup {
  final BuildContext context;
  final Image? image;
  final double backgroundOpacity;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle1;
  final TextStyle? subtitle1Style;
  final RichText? subtitleRich1;
  final String? subtitle2;
  final TextStyle? subtitle2Style;
  final String? subtitle3;
  final TextStyle? subtitle3Style;
  final String? footerText;
  final TextStyle? footerTextStyle;
  final String labelButtonAccept;
  final Function? onAccept;
  final String? labelButtonCancel;
  final Function? onCancel;
  final bool isCancellable;

  InformationAlertPopup(
      {required this.context,
      this.image,
      this.backgroundOpacity = 0.8,
      required this.title,
      this.titleStyle,
      this.subtitle1,
      this.subtitle1Style,
      this.subtitleRich1,
      this.subtitle2,
      this.subtitle2Style,
      this.subtitle3,
      this.subtitle3Style,
      this.footerText,
      this.footerTextStyle,
      required this.labelButtonAccept,
      this.onAccept,
      this.labelButtonCancel,
      this.onCancel,
      this.isCancellable = false});

  final double radius = 10;

  Future show() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return _dialog();
        });
  }

  _dialog() {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(30),
          color: Colors.transparent,
        ),
        Center(
          child: Container(
            child: _body(),
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ],
    );
  }

  _body() {
    return Stack(
      children: [
        _content(),
        _buttonExit(),
      ],
    );
  }

  _content() {
    return SingleChildScrollView(
        child: Container(
      key: const Key('informationAlertPopupContent'),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start, children: _getChildren()),
    ));
  }

  _getChildren() {
    List<Widget> children = [];
    if (image != null) {
      children.addAll(
          [const SizedBox(height: 10), _image(), const SizedBox(height: 20)]);
    }

    if (title.hasValue()) {
      children.addAll([_title(), const SizedBox(height: 20)]);
    }

    if (subtitle1 != null || subtitleRich1 != null) {
      children.addAll([_subtitle1(), const SizedBox(height: 5)]);
    }

    if (subtitle2 != null) {
      children.addAll([_subtitle2(), const SizedBox(height: 5)]);
    }

    if (subtitle3 != null) {
      children.addAll([_subtitle3(), const SizedBox(height: 5)]);
    }

    if (footerText != null) {
      children.addAll([
        const SizedBox(height: 10),
        _footerText(),
        const SizedBox(height: 15)
      ]);
    }

    children.addAll([const SizedBox(height: 15), _buttons()]);
    return children;
  }

  _image() {
    return image;
  }

  _title() {
    return Material(
        type: MaterialType.transparency,
        child: Text(
          title.hasValue() ? title : "",
          softWrap: true,
          textAlign: TextAlign.center,
          style: titleStyle ??
              const TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.w700,
                fontSize: kFontSize43,
              ),
        ));
  }

  _subtitle1() {
    return subtitleRich1 ??
        Material(
          type: MaterialType.transparency,
          child: Text(
            subtitle1 ?? "",
            textAlign: TextAlign.center,
            softWrap: true,
            style: subtitle1Style ??
                const TextStyle(
                  color: kPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: kFontSize35,
                ),
          ),
        );
  }

  _subtitle2() {
    return Material(
        type: MaterialType.transparency,
        child: Text(
          subtitle2 ?? "",
          textAlign: TextAlign.center,
          softWrap: true,
          style: subtitle2Style ??
              const TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.w400,
                fontSize: kFontSize35,
              ),
        ));
  }

  _subtitle3() {
    return Material(
        type: MaterialType.transparency,
        child: Text(
          subtitle3 ?? "",
          textAlign: TextAlign.center,
          softWrap: true,
          style: subtitle3Style ??
              const TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.w400,
                fontSize: kFontSize35,
              ),
        ));
  }

  _footerText() {
    return Material(
        type: MaterialType.transparency,
        child: Text(
          footerText ?? "",
          textAlign: TextAlign.center,
          softWrap: true,
          style: footerTextStyle ??
              const TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.w400,
                fontSize: kFontSize35,
              ),
        ));
  }

  _buttons() {
    return Row(
      children: [
        _buttonCancel(),
        _buttonAccept(),
      ],
    );
  }

  _buttonExit() {
    return Visibility(
      visible: isCancellable,
      child: Positioned.fill(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: GestureDetector(
              key: const Key('informationAlertPopupExitButton'),
              onTap: () {
                Navigator.pop(context, false);
              },
              child: Image.asset(
                "images/icon_close.png",
                fit: BoxFit.cover,
                alignment: Alignment.center,
                color: kSecondary,
                height: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonAccept() {
    return Flexible(
      child: Padding(
        padding: labelButtonCancel != null
            ? const EdgeInsets.only(right: 20)
            : const EdgeInsets.only(left: 50, right: 50),
        child: TextButton(
          key: const Key('informationAlertPopupAcceptButton'),
          onPressed: () {
            Navigator.pop(context, true);
            if (onAccept != null) {
              onAccept!();
            }
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: kSecondary,
            textStyle: const TextStyle(fontSize: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(0),
            height: 40,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  labelButtonAccept.hasValue() ? labelButtonAccept : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: kFontSize35,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonCancel() {
    return Visibility(
      visible: labelButtonCancel != null,
      child: Flexible(
        child: TextButton(
          key: const Key('informationAlertPopupCancelButton'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Navigator.pop(context, false);

            if (onCancel != null) {
              onCancel!();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(0),
            height: 40,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  labelButtonCancel ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: kFontSize35,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
