import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'inventory_management_plugin_method_channel.dart';

abstract class InventoryManagementPluginPlatform extends PlatformInterface {
  /// Constructs a InventoryManagementPluginPlatform.
  InventoryManagementPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static InventoryManagementPluginPlatform _instance = MethodChannelInventoryManagementPlugin();

  /// The default instance of [InventoryManagementPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelInventoryManagementPlugin].
  static InventoryManagementPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InventoryManagementPluginPlatform] when
  /// they register themselves.
  static set instance(InventoryManagementPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
