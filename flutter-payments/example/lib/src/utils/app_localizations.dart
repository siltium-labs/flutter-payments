import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

//https://medium.com/@danelop.ecu/flutter-f%C3%A1cil-de-internacionalizar-usando-provider-y-json-320ffe7b3fbd
// using in testing purpose https://medium.com/flutterpub/testing-localized-widget-in-flutter-3bfa5492bc84

class AppLocalizations {

  AppLocalizations(
    this.locale, {
    this.isTest = false,
  });

  final Locale locale;
  bool isTest;
  Map<String, String>? _localizedStrings;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  //static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate(isTest: isTest);

  Future<AppLocalizations> load() async {
    String jsonString = await rootBundle.loadString('i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return AppLocalizations(locale);
  }

  Future<AppLocalizations> loadTest(Locale locale) async {
    return AppLocalizations(locale);
  }

  String? translate(String key) {
    if (isTest) return '';
    return _localizedStrings![key];
  }
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate({
    this.isTest = false,
  });

  final bool isTest;
  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale, isTest: isTest);
    if (isTest) {
      await localizations.loadTest(locale);
    } else {
      await localizations.load();
    }

    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
