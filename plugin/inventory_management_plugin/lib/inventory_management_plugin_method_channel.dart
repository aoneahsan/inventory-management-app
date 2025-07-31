import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'inventory_management_plugin_platform_interface.dart';

/// An implementation of [InventoryManagementPluginPlatform] that uses method channels.
class MethodChannelInventoryManagementPlugin extends InventoryManagementPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('inventory_management_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
