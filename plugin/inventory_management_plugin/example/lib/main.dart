import 'package:flutter/material.dart';
import 'package:inventory_management_plugin/inventory_management_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/pos_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/reports_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize plugin with configuration
  final prefs = await SharedPreferences.getInstance();
  final config = InventoryPluginConfig(
    appName: 'Inventory Manager Demo',
    databaseAdapter: SqfliteAdapter(),
    storageAdapter: SharedPreferencesAdapter(prefs),
    enableOfflineSync: true,
    enableMultiBranch: true,
    features: FeatureConfig(
      enableProducts: true,
      enableCategories: true,
      enableInventoryTracking: true,
      enableBarcodeScanning: true,
      enablePOS: true,
      enableSuppliers: true,
      enableCustomers: true,
      enableReports: true,
      enableMultiBranch: true,
      enableBatchTracking: true,
      enableSerialTracking: true,
      enableStockTransfer: true,
      enablePurchaseOrders: true,
      enableTaxManagement: true,
    ),
    themeConfig: ThemeConfig(
      primaryColor: '#2196F3',
      useMaterial3: true,
      enableDarkMode: true,
    ),
  );
  
  await InventoryManagementPlugin.initialize(config);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InventoryManagementPlugin.createApp(
      title: 'Inventory Manager Demo',
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const ProductsScreen(),
    const InventoryScreen(),
    const POSScreen(),
    const ReportsScreen(),
  ];
  
  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.inventory_2_outlined),
      selectedIcon: Icon(Icons.inventory_2),
      label: 'Products',
    ),
    NavigationDestination(
      icon: Icon(Icons.warehouse_outlined),
      selectedIcon: Icon(Icons.warehouse),
      label: 'Inventory',
    ),
    NavigationDestination(
      icon: Icon(Icons.point_of_sale_outlined),
      selectedIcon: Icon(Icons.point_of_sale),
      label: 'POS',
    ),
    NavigationDestination(
      icon: Icon(Icons.analytics_outlined),
      selectedIcon: Icon(Icons.analytics),
      label: 'Reports',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: _destinations,
      ),
    );
  }
}
