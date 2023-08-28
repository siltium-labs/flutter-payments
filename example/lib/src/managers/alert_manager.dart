import 'package:flutter/cupertino.dart';
import '../../src/ui/popups/alert_popup.dart';

class AlertManager {
  static final AlertManager _instance = AlertManager._constructor();

  factory AlertManager() {
    return _instance;
  }

  AlertManager._constructor();

  openErrorAlert(BuildContext context,
      {required String title,
      required String description,
      required String labelButtonAccept,
      String? labelOptionalButton,
      Function? onClose,
      Function? onAcceptPressed,
      Function? onOptionalPressed}) {
    return AlertPopup(
            context: context,
            title: title,
            description: description,
            labelButtonAccept: labelButtonAccept,
            labelOptionalButton: labelOptionalButton,
            onClose: onClose,
            onAcceptPressed: onAcceptPressed,
            onOptionalPressed: onOptionalPressed)
        .show();
  }

  openErrorAlertDefault(BuildContext context, {required String description}) {
    return AlertPopup(
            context: context,
            title: "Alerta",
            description: description,
            labelButtonAccept: "Aceptar",
            labelOptionalButton: null,
            onClose: null,
            onAcceptPressed: () {},
            onOptionalPressed: () {})
        .show();
  }
}
