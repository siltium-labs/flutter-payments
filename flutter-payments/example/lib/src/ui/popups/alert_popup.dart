import 'package:flutter/material.dart';
import '/src/utils/extensions.dart';

import '../../../values/k_colors.dart';
import '../../../values/k_values.dart';

class AlertPopup {
  final BuildContext context;
  final String title;
  final double backgroundOpacity;
  final String description;
  final String labelButtonAccept;
  final String? labelOptionalButton;
  final Function? onClose;
  final Function? onAcceptPressed;
  final Function? onOptionalPressed;
  final String? iconPath;
  bool showImage = true;

  AlertPopup({
    required this.context,
    required this.title,
    required this.description,
    required this.labelButtonAccept,
    this.labelOptionalButton,
    this.onClose,
    this.onAcceptPressed,
    this.onOptionalPressed,
    this.backgroundOpacity = 0.5,
    this.iconPath,
    this.showImage = true,
  });

  final double radius = 20;

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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kPrimary.withOpacity(backgroundOpacity),
                kPrimary.withOpacity(backgroundOpacity)
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            // width: width,
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
      children: <Widget>[
        _content(),
        _buttonExit(),
      ],
    );
  }

  _content() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 15,
          bottom: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _icon(),
            const SizedBox(height: 10),
            _title(),
            //const Divider(thickness: 2),
            const SizedBox(height: 15),
            _description(),
            const SizedBox(height: 15),
            _buttons(),
          ],
        ),
      ),
    );
  }

  _icon() {
    if (showImage) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Image.asset(iconPath ?? "images/common/icon_popup_alert.png"),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _title() {
    return Material(
      type: MaterialType.transparency,
      child: Text(
        title.isNotEmpty ? title : "",
        softWrap: true,
        style: const TextStyle(
          color: kPrimary,
          fontSize: kFontSize60,
          fontWeight: kFontWeightBold,
        ),
      ),
    );
  }

  _description() {
    return Material(
      type: MaterialType.transparency,
      child: Text(
        description.isNotEmpty ? description : "",
        softWrap: true,
        style: const TextStyle(
          color: kGrayT1,
          fontSize: kFontSize43,
          fontWeight: kFontWeightRegular,
        ),
      ),
    );
  }

  _buttons() {
    return Row(
      children: [
        Visibility(
          visible: !labelOptionalButton.isNullOrEmpty(),
          child: Expanded(
            child: _buttonOptional(),
          ),
        ),
        Visibility(
          visible: labelOptionalButton != null
              ? !labelOptionalButton!.isNullOrEmpty()
              : false,
          child: const SizedBox(
            width: 10,
          ),
        ),
        Expanded(
          child: _buttonAccept(),
        ),
      ],
    );
  }

  _buttonAccept() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        foregroundColor: kPrimary,
        backgroundColor: kPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: () {
        Navigator.pop(context, false);
        if (onAcceptPressed != null) {
          onAcceptPressed!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        height: 40,
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              labelButtonAccept.isNotEmpty ? labelButtonAccept : "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: kFontSize40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonOptional() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: kRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: () {
        Navigator.pop(context, false);
        if (onAcceptPressed != null) {
          onOptionalPressed!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        height: 40,
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              labelOptionalButton ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: kFontSize40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonExit() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, right: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context, false);
              if (onClose != null) {
                onClose!();
              }
            },
            child: const Icon(
              Icons.close_rounded,
              size: 25,
              color: kPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
