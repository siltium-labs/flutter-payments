import 'package:flutter/material.dart';
import 'package:flutter_payments_example/src/managers/page_manager.dart';
import 'package:flutter_payments_example/values/k_colors.dart';
import 'package:flutter_payments_example/values/k_values.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../utils/page_args.dart';
import '../page_controllers/home_page_controller.dart';

class HomePage extends StatefulWidget {
  final PageArgs? args;
  const HomePage(this.args, {Key? key}) : super(key: key);

  @override
  HomePagePageState createState() => HomePagePageState();
}

class HomePagePageState extends StateMVC<HomePage> {
  late HomePageController _con;
  PageArgs? args;

  HomePagePageState() : super(HomePageController()) {
    _con = HomePageController.con;
  }

  @override
  void initState() {
    _con.initPage(arguments: widget.args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        PageManager().openExitApplicationPopup();
        return false;
      },
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: kWhite,
          appBar: AppBar(
            title: const Text('Plugin example app'),
            backgroundColor: kPrimary,
          ),
          body: content(),
        ),
      ),
    );
  }

  Widget content() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              'Running on: ${_con.platformVersion}',
              style: const TextStyle(
                color: kGray,
                fontSize: kFontSize35,
                fontWeight: kFontWeightRegular,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                backgroundColor: kPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                "Pagar con Mercado Pago",
                style: TextStyle(
                  color: kWhite,
                  fontSize: kFontSize40,
                ),
              ),
              onPressed: () {
                _con.payWithMercadoPago();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                backgroundColor: kPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                "Token Card Mercado Pago",
                style: TextStyle(
                  color: kWhite,
                  fontSize: kFontSize40,
                ),
              ),
              onPressed: () {
                _con.openPopup();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
