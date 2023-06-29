import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'multipay_plugin_platform_interface.dart';

/// An implementation of [MultipayPluginPlatform] that uses method channels.
class MethodChannelMultipayPlugin extends MultipayPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('multipay_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<dynamic> startMPCheckout() async {
    return await methodChannel.invokeMapMethod<String, dynamic>('mpCheckout');
  }
}
