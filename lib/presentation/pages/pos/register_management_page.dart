import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/register.dart';
import '../../../services/pos/register_service.dart';
import '../../../services/database/database.dart';
import '../../../services/sync/sync_service.dart';
import '../../providers/auth_provider.dart';

final registerServiceProvider = Provider<RegisterService>((ref) {
  return RegisterService(
    database: AppDatabase.instance,
    syncService: ref.watch(syncServiceProvider),
  );
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(database: AppDatabase.instance);
});

class RegisterManagementPage extends ConsumerStatefulWidget {
  const RegisterManagementPage({super.key});

  @override
  ConsumerState<RegisterManagementPage> createState() => _RegisterManagementPageState();
}

class _RegisterManagementPageState extends ConsumerState<RegisterManagementPage> {
  List<Register> _openRegisters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRegisters();
  }

  Future<void> _loadRegisters() async {
    final currentOrg = ref.read(currentOrganizationProvider);
    if (currentOrg == null) return;

    try {
      final registerService = ref.read(registerServiceProvider);
      final registers = await registerService.getOpenRegisters(
        currentOrg.id,
      );
      
      setState(() {
        _openRegisters = registers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading registers: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadRegisters,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _openRegisters.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.point_of_sale,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No open registers',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => _showOpenRegisterDialog(),
                        icon: const Icon(Icons.add),
                        label: const Text('Open Register'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Open Registers',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _showOpenRegisterDialog(),
                            icon: const Icon(Icons.add),
                            label: const Text('Open Register'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _openRegisters.length,
                        itemBuilder: (context, index) {
                          final register = _openRegisters[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.point_of_sale),
                              ),
                              title: Text(register.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Opened at: ${_formatDateTime(register.openedAt)}'),
                                  Text('Current Balance: \$${register.currentBalance.toStringAsFixed(2)}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () => _showRegisterDetails(register),
                                    child: const Text('Details'),
                                  ),
                                  TextButton(
                                    onPressed: () => _showCloseRegisterDialog(register),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/pos'),
        icon: const Icon(Icons.point_of_sale),
        label: const Text('Go to POS'),
      ),
    );
  }

  void _showOpenRegisterDialog() {
    final nameController = TextEditingController();
    final balanceController = TextEditingController(text: '0');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Open Register'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Register Name',
                hintText: 'e.g., Register 1',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: balanceController,
              decoration: const InputDecoration(
                labelText: 'Opening Balance',
                prefixText: '\$',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter register name')),
                );
                return;
              }
              
              final balance = double.tryParse(balanceController.text) ?? 0;
              Navigator.pop(context);
              await _openRegister(nameController.text, balance);
            },
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }

  void _showCloseRegisterDialog(Register register) {
    final Map<String, TextEditingController> denominationControllers = {
      '100': TextEditingController(text: '0'),
      '50': TextEditingController(text: '0'),
      '20': TextEditingController(text: '0'),
      '10': TextEditingController(text: '0'),
      '5': TextEditingController(text: '0'),
      '1': TextEditingController(text: '0'),
      '0.25': TextEditingController(text: '0'),
      '0.10': TextEditingController(text: '0'),
      '0.05': TextEditingController(text: '0'),
      '0.01': TextEditingController(text: '0'),
    };
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Close Register - ${register.name}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Expected Balance: \$${register.expectedBalance.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              const Text('Count Cash Denominations:'),
              const SizedBox(height: 8),
              ...denominationControllers.entries.map((entry) {
                return Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text('\$${entry.key}'),
                    ),
                    Expanded(
                      child: TextField(
                        controller: entry.value,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final denominations = <String, int>{};
              denominationControllers.forEach((key, controller) {
                final count = int.tryParse(controller.text) ?? 0;
                if (count > 0) {
                  denominations[key] = count;
                }
              });
              
              Navigator.pop(context);
              await _closeRegister(register.id, denominations);
            },
            child: const Text('Close Register'),
          ),
        ],
      ),
    );
  }

  void _showRegisterDetails(Register register) {
    // TODO: Show detailed register information and transactions
  }

  Future<void> _openRegister(String name, double openingBalance) async {
    try {
      final organization = ref.read(currentOrganizationProvider);
      final user = ref.read(currentUserProvider);
      final registerService = ref.read(registerServiceProvider);
      
      if (organization == null || user == null) {
        throw Exception('No organization or user found');
      }
      
      await registerService.openRegister(
        organizationId: organization.id,
        name: name,
        openingBalance: openingBalance,
        userId: user.id,
      );
      
      await _loadRegisters();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Register opened successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening register: $e')),
        );
      }
    }
  }

  Future<void> _closeRegister(String registerId, Map<String, int> denominations) async {
    try {
      final user = ref.read(currentUserProvider);
      final registerService = ref.read(registerServiceProvider);
      
      if (user == null) {
        throw Exception('No user found');
      }
      
      await registerService.closeRegister(
        registerId: registerId,
        userId: user.id,
        denominations: denominations,
      );
      
      await _loadRegisters();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Register closed successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error closing register: $e')),
        );
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }
}