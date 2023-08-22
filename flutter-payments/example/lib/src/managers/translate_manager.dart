import 'package:flutter_gen/gen_l10n/app_localizations.dart' as i10n;
import 'page_manager.dart';

class TranslateManager {
  static final TranslateManager _instance = TranslateManager._constructor();

  factory TranslateManager() {
    return _instance;
  }

  TranslateManager._constructor();

  i10n.AppLocalizations texts(){
    return i10n.AppLocalizations.of(PageManager().navigatorKey.currentContext!)!;
  }
}
