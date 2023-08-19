import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_payments/flutter_payments.dart';

void main() {
  runApp(const MyApp());
}

// const publicKey = "YOUR KEY";
// const preferenceId = "YOUR ID";
// const accessTokenTest = "YOUR ACCESS TOKEN";
const publicKeyTest = "TEST-81d8a608-abf0-4d87-8575-edee2427d378";
const preferenceIdTest = "222344382-b941a00f-b511-4e1d-bac5-d74f78586c09";
const accessTokenTest =
    "TEST-1563356252471753-080709-33fb458ed3d3fc24b9d54032f0e045fd-222344382";

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await FlutterPayments.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(
                onPressed: () {
                  payWithMercadoPago();
                },
                child: const Text("Pagar con Mercado Pago"),
              ),
              ElevatedButton(
                onPressed: () {
                  getTokenCardMercadoPago();
                },
                child: const Text("Token Card Mercado Pago"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void payWithMercadoPago() async {
    PaymentResult paymentResult =
        await FlutterPayments.payWithMercadoPagoCheckout(
      publicKey: publicKeyTest,
      preferenceId: preferenceIdTest,
    );

    if (paymentResult.errorMessage != null) {
      print("Pago Error: ${paymentResult.errorMessage}");
    } else if (paymentResult.result.toLowerCase() == "canceled") {
      print("Pago Cancelado");
    } else if (paymentResult.status == "rejected") {
      print("Pago Rechazado");
    } else if (paymentResult.status == "approved") {
      print("Pago Aprobado");
      ;
    }
  }

  void getTokenCardMercadoPago() async {
    String token = await FlutterPayments.getTokenCardMercadoPago(
      accessToken: accessTokenTest,
      //documentType: "DNI",
      documentNumber: "12345678",
      cardNumber: "4509953566233704",
      cardHolder: "JORGE TEST",
      expirationMonth: "11",
      expirationYear: "2025",
      cvv: "123",
    );

    print("Token Card: $token");
  }
}
