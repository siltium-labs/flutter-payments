import 'package:flutter/material.dart';
import 'package:flutter_payments/src/values/k_colors.dart';

class WebViewPopup {
  final BuildContext context;
  Widget content;
  Color? themColor;
  bool isCancellable = true;
  double? radius;

  WebViewPopup({
    required this.context,
    required this.content,
    this.themColor,
    this.isCancellable = true,
    this.radius,
  });

  final double defaultRadius = 20;

  Future<dynamic> show() {
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
      color: themColor != null
          ? themColor!.withOpacity(0.5)
          : kPrimary.withOpacity(0.5),
    );
  }

  _card() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 30,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius ?? defaultRadius),
          ),
          child: _body(),
        ),
      ),
    );
  }

  _body() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? defaultRadius),
          child: content,
        ),
        _buttonExit(),
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
            padding: const EdgeInsets.only(
              top: 10,
              right: 10,
            ),
            child: GestureDetector(
              key: const Key('cancelWebViewPopupExitButton'),
              onTap: () {
                Navigator.pop(context);
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
