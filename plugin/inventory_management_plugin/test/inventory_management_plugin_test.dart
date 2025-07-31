import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management_plugin/inventory_management_plugin.dart';
import 'package:inventory_management_plugin/inventory_management_plugin_platform_interface.dart';
import 'package:inventory_management_plugin/inventory_management_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInventoryManagementPluginPlatform
    with MockPlatformInterfaceMixin
    implements InventoryManagementPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final InventoryManagementPluginPlatform initialPlatform = InventoryManagementPluginPlatform.instance;

  test('$MethodChannelInventoryManagementPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInventoryManagementPlugin>());
  });

  test('getPlatformVersion', () async {
    InventoryManagementPlugin inventoryManagementPlugin = InventoryManagementPlugin();
    MockInventoryManagementPluginPlatform fakePlatform = MockInventoryManagementPluginPlatform();
    InventoryManagementPluginPlatform.instance = fakePlatform;

    expect(await inventoryManagementPlugin.getPlatformVersion(), '42');
  });
}
