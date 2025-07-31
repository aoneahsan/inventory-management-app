import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/customer.dart';
import '../../../services/customer/customer_service.dart';
import '../../providers/auth_provider.dart';

final customerServiceProvider = Provider<CustomerService>((ref) {
  return CustomerService();
});

final customersProvider = FutureProvider.family<List<Customer>, Map<String, dynamic>>((ref, filters) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final customerService = ref.watch(customerServiceProvider);
  return customerService.getCustomers(
    org.id,
    searchQuery: filters['searchQuery'] as String?,
    customerType: filters['customerType'] as String?,
    activeOnly: filters['activeOnly'] as bool?,
  );
});

final customerStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final customerService = ref.watch(customerServiceProvider);
  return customerService.getCustomerStats(org.id);
});

class CustomersPage extends ConsumerStatefulWidget {
  const CustomersPage({super.key});

  @override
  ConsumerState<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends ConsumerState<CustomersPage> {
  final _searchController = TextEditingController();
  String? _selectedCustomerType;
  bool _showActiveOnly = true;
  final _selectedCustomers = <String>{};
  bool _isSelectionMode = false;

  Map<String, dynamic> get _filters => {
    'searchQuery': _searchController.text,
    'customerType': _selectedCustomerType,
    'activeOnly': _showActiveOnly,
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customersProvider(_filters));
    final statsAsync = ref.watch(customerStatsProvider);
    final user = ref.watch(currentUserProvider);
    
    final canManageCustomers = user?.hasPermission('manage_customers') ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode 
            ? '${_selectedCustomers.length} selected' 
            : 'Customers'),
        leading: _isSelectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _isSelectionMode = false;
                    _selectedCustomers.clear();
                  });
                },
              )
            : null,
        actions: [
          if (_isSelectionMode) ...[
            IconButton(
              icon: const Icon(Icons.email),
              onPressed: _selectedCustomers.isEmpty 
                  ? null 
                  : () => _sendBulkEmail(),
            ),
            IconButton(
              icon: const Icon(Icons.label),
              onPressed: _selectedCustomers.isEmpty 
                  ? null 
                  : () => _exportLabels(),
            ),
          ] else ...[
            IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: () => _exportCustomers(),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => ref.invalidate(customersProvider),
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Stats Cards
          if (!_isSelectionMode)
            Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              child: statsAsync.when(
                data: (stats) => Row(
                  children: [
                    _buildStatCard(
                      'Total Customers',
                      stats['totalCustomers'].toString(),
                      Icons.people,
                      Colors.blue,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      'Active',
                      stats['activeCustomers'].toString(),
                      Icons.check_circle,
                      Colors.green,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      'With Credit',
                      stats['customersWithCredit'].toString(),
                      Icons.credit_card,
                      Colors.orange,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      'Outstanding',
                      '\$${stats['totalOutstandingBalance'].toStringAsFixed(2)}',
                      Icons.account_balance_wallet,
                      Colors.red,
                    ),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
            ),
          
          // Search and Filters
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search customers...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Customer Type Filter
                DropdownButton<String?>(
                  value: _selectedCustomerType,
                  hint: const Text('All Types'),
                  items: const [
                    DropdownMenuItem(value: null, child: Text('All Types')),
                    DropdownMenuItem(value: 'retail', child: Text('Retail')),
                    DropdownMenuItem(value: 'wholesale', child: Text('Wholesale')),
                    DropdownMenuItem(value: 'corporate', child: Text('Corporate')),
                  ],
                  onChanged: (value) => setState(() {
                    _selectedCustomerType = value;
                  }),
                ),
                const SizedBox(width: 12),
                
                // Active Only Filter
                FilterChip(
                  label: const Text('Active Only'),
                  selected: _showActiveOnly,
                  onSelected: (selected) => setState(() {
                    _showActiveOnly = selected;
                  }),
                ),
              ],
            ),
          ),
          
          // Customers List
          Expanded(
            child: customersAsync.when(
              data: (customers) {
                if (customers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No customers found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: canManageCustomers
                              ? () => context.push('/customers/new')
                              : null,
                          icon: const Icon(Icons.add),
                          label: const Text('Add First Customer'),
                        ),
                      ],
                    ),
                  );
                }
                
                return ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    final isSelected = _selectedCustomers.contains(customer.id);
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: _isSelectionMode
                            ? Checkbox(
                                value: isSelected,
                                onChanged: (_) => _toggleSelection(customer.id),
                              )
                            : CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                child: Text(
                                  customer.name.substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                        title: Text(customer.name),
                        subtitle: Row(
                          children: [
                            if (customer.code != null) ...[
                              Icon(Icons.tag, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(customer.code!),
                              const SizedBox(width: 12),
                            ],
                            if (customer.email != null) ...[
                              Icon(Icons.email, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  customer.email!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (customer.loyaltyPoints > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.purple[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, size: 14, color: Colors.purple[700]),
                                    const SizedBox(width: 4),
                                    Text(
                                      customer.loyaltyPoints.toString(),
                                      style: TextStyle(
                                        color: Colors.purple[700],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (customer.currentBalance > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '\$${customer.currentBalance.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 8),
                            Chip(
                              label: Text(
                                customer.customerType.toUpperCase(),
                                style: const TextStyle(fontSize: 11),
                              ),
                              visualDensity: VisualDensity.compact,
                              backgroundColor: _getCustomerTypeColor(customer.customerType),
                            ),
                          ],
                        ),
                        onTap: () => context.push('/customers/${customer.id}'),
                        onLongPress: canManageCustomers
                            ? () {
                                setState(() {
                                  _isSelectionMode = true;
                                  _selectedCustomers.add(customer.id);
                                });
                              }
                            : null,
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 16),
                    Text('Error: $error'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(customersProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: canManageCustomers && !_isSelectionMode
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/customers/new'),
              icon: const Icon(Icons.add),
              label: const Text('Add Customer'),
            )
          : null,
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCustomerTypeColor(String type) {
    switch (type) {
      case 'retail':
        return Colors.blue[100]!;
      case 'wholesale':
        return Colors.green[100]!;
      case 'corporate':
        return Colors.orange[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  void _toggleSelection(String customerId) {
    setState(() {
      if (_selectedCustomers.contains(customerId)) {
        _selectedCustomers.remove(customerId);
      } else {
        _selectedCustomers.add(customerId);
      }
    });
  }

  Future<void> _sendBulkEmail() async {
    // TODO: Implement bulk email functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bulk email feature coming soon')),
    );
  }

  Future<void> _exportLabels() async {
    // TODO: Implement label export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Label export feature coming soon')),
    );
  }

  Future<void> _exportCustomers() async {
    // TODO: Implement customer export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Customer export feature coming soon')),
    );
  }
}