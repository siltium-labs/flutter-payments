import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_pago/mercado_pago.dart';
import 'package:mercado_pago/mercado_pago_platform_interface.dart';
import 'package:mercado_pago/mercado_pago_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMercadoPagoPlatform
    with MockPlatformInterfaceMixin
    implements MercadoPagoPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MercadoPagoPlatform initialPlatform = MercadoPagoPlatform.instance;

  test('$MethodChannelMercadoPago is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMercadoPago>());
  });

  test('getPlatformVersion', () async {
    //MercadoPago mercadoPagoPlugin = MercadoPago();
    MockMercadoPagoPlatform fakePlatform = MockMercadoPagoPlatform();
    MercadoPagoPlatform.instance = fakePlatform;

    expect(await MercadoPago.platformVersion, '42');
  });
}
