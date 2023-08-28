import 'package:flutter/material.dart';
import 'package:flutter_payments/src/values/k_colors.dart';

import '../../flutter_payments.dart';

class CreditCardFormPopup {
  final BuildContext context;
  Color? themColor;
  String accessToken;
  bool isCancellable = true;

  CreditCardFormPopup({
    required this.context,
    required this.accessToken,
    this.themColor,
    this.isCancellable = true,
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
      children: [
        CreditCardFormPopupDialog(
          context: context,
          accessToken: accessToken,
          themColor: themColor,
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
              key: const Key('cancelCreditCardFormPopupExitButton'),
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

// ignore: must_be_immutable
class CreditCardFormPopupDialog extends StatefulWidget {
  final BuildContext context;
  Color? themColor;
  String accessToken;

  CreditCardFormPopupDialog({
    required this.context,
    required this.accessToken,
    this.themColor,
    Key? key,
  }) : super(key: key);

  @override
  State<CreditCardFormPopupDialog> createState() =>
      _CreditCardFormPopupDialogState();
}

class _CreditCardFormPopupDialogState extends State<CreditCardFormPopupDialog> {
  @override
  void initState() {
    super.initState();
  }

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
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: CardFormWidgets(
        context: widget.context,
        accessToken: widget.accessToken,
        themColor: widget.themColor,
      ),
    );
  }
}
