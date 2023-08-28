// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../utils/page_args.dart';

import '../page_controllers/init_page_controller.dart';

class InitPage extends StatefulWidget {
  final PageArgs? args;
  const InitPage(this.args, {Key? key}) : super(key: key);
  @override
  _InitPageState createState() => _InitPageState(args);
}

class _InitPageState extends StateMVC<InitPage> {
  late InitPageController _con;
  PageArgs? args;
  _InitPageState(PageArgs? arguments) : super(InitPageController(arguments)) {
    _con = InitPageController.con;
    args = arguments;
  }
  @override
  void initState() {
    _con.initPage(arguments: args);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimatedSplashScreen.withScreenFunction(
          screenFunction: () async {
            await _con.init();
            return _con.goInitialPage();
          },
          animationDuration: const Duration(milliseconds: 1000),
          backgroundColor: Colors.white,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          curve: Curves.linear,
          splashIconSize: double.maxFinite,
          centered: true,
          splash: _content(),
        ),
      ),
    );
  }

  _content() {
    //TO IMPLEMENT: splash body
    return const FlutterLogo(
      size: 100,
    );
  }
}
