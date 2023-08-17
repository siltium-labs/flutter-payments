import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_payments/flutter_payments.dart';
import 'package:flutter_payments/flutter_payments_platform_interface.dart';
import 'package:flutter_payments/flutter_payments_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPaymentsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPaymentsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterPaymentsPlatform initialPlatform =
      FlutterPaymentsPlatform.instance;

  test('$MethodChannelFlutterPayments is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPayments>());
  });

  test('getPlatformVersion', () async {
    //FlutterPayments flutterPaymentsPlugin = FlutterPayments();
    MockFlutterPaymentsPlatform fakePlatform = MockFlutterPaymentsPlatform();
    FlutterPaymentsPlatform.instance = fakePlatform;

    expect(await FlutterPayments.platformVersion, '42');
  });
}
