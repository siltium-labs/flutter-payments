import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'multipay_plugin_method_channel.dart';

abstract class MultipayPluginPlatform extends PlatformInterface {
  /// Constructs a MultipayPluginPlatform.
  MultipayPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MultipayPluginPlatform _instance = MethodChannelMultipayPlugin();

  /// The default instance of [MultipayPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMultipayPlugin].
  static MultipayPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MultipayPluginPlatform] when
  /// they register themselves.
  static set instance(MultipayPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<dynamic> startMPCheckout() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> mpGetCardId() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
