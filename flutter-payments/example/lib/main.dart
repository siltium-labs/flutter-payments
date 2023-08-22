import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'src/managers/page_manager.dart';
import 'src/providers/app_provider.dart';
import 'values/k_colors.dart';
import '/src/ui/pages/init_page.dart';
import '/src/enums/culture.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kPrimary,
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyHomePageState? state =
        context.findAncestorStateOfType<_MyHomePageState>();
    state!.changeLanguage(newLocale);
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  late Locale _locale = const Locale("es", '');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''),
        Locale('en', ''),
      ],
      navigatorKey: PageManager().navigatorKey,
      locale: _locale,
      onGenerateRoute: (settings) {
        return PageManager().getRoute(settings);
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scrollbarTheme: ScrollbarThemeData(
          trackColor: MaterialStateProperty.all(Colors.grey),
          thumbColor: MaterialStateProperty.all(Colors.grey),
          trackBorderColor: MaterialStateProperty.all(Colors.grey),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'flutter_template',
      home: _initPage(),
    );
  }

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  getCode(Culture code) {
    switch (code) {
      case Culture.es:
        return 'es';
      case Culture.en:
        return 'en';
    }
  }

  _initPage() {
    return InitPage(null);
  }
}
