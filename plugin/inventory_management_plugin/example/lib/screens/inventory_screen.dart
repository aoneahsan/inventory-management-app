import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_plugin/inventory_management_plugin.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inventory'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Stock Levels'),
              Tab(text: 'Movements'),
              Tab(text: 'Transfers'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _StockLevelsTab(),
            _MovementsTab(),
            _TransfersTab(),
          ],
        ),
      ),
    );
  }
}

class _StockLevelsTab extends ConsumerWidget {
  const _StockLevelsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('Stock levels overview would be displayed here'),
    );
  }
}

class _MovementsTab extends ConsumerWidget {
  const _MovementsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('Inventory movements would be listed here'),
    );
  }
}

class _TransfersTab extends ConsumerWidget {
  const _TransfersTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('Stock transfers would be managed here'),
    );
  }
}