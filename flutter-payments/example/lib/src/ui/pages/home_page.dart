import 'package:flutter/material.dart';
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text('Running on: ${_con.platformVersion}'),
                ElevatedButton(
                  onPressed: () {
                    _con.payWithMercadoPago();
                  },
                  child: const Text("Pagar con Mercado Pago"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _con.openPopup();
                  },
                  child: const Text("Token Card Mercado Pago"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
