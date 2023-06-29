import 'package:flutter/material.dart';
import 'package:multipay_plugin/src/utility/futuristic.dart';

import 'loading_component.dart';

class LoadingPopup {
  final BuildContext context;
  final Color backgroundColor;
  final Future onLoading;
  Gradient? gradient;
  Function? onResult;
  Function? onError;
  bool usesGradient;

  LoadingPopup({
    required this.context,
    required this.onLoading,
    this.onResult,
    this.gradient,
    this.onError,
    this.usesGradient = true,
    this.backgroundColor = const Color(0x80FFFFFF),
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
    return Futuristic(
      autoStart: true,
      futureBuilder: () => onLoading,
      busyBuilder: (context) => body(),
      onData: (data) {
        Navigator.pop(context);
        onResult!(data);
      },
      onError: (error, retry) {
        Navigator.pop(context);
        onError!(error);
      },
    );
  }

  body() {
    return Container(
      decoration: BoxDecoration(
        color: !usesGradient ? backgroundColor : null,
        gradient: usesGradient
            ? gradient ??
                LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.blue.withOpacity(0.5),
                  ],
                )
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          loadingComponent(true, color: Colors.blue, size: 50),
        ],
      ),
    );
  }
}
