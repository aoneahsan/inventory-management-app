import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/customer.dart';
import '../../../services/customer/customer_service.dart';
import '../../providers/organization_provider.dart';

final customerFormProvider = StateNotifierProvider.autoDispose<CustomerFormNotifier, CustomerFormState>((ref) {
  return CustomerFormNotifier(ref);
});

class CustomerFormState {
  final bool isLoading;
  final String? error;
  final Customer? customer;

  CustomerFormState({
    this.isLoading = false,
    this.error,
    this.customer,
  });
}

class CustomerFormNotifier extends StateNotifier<CustomerFormState> {
  final Ref ref;
  final CustomerService _customerService;

  CustomerFormNotifier(this.ref) 
      : _customerService = CustomerService(),
        super(CustomerFormState());

  Future<void> loadCustomer(String customerId) async {
    state = CustomerFormState(isLoading: true);
    
    try {
      final customer = await _customerService.getCustomer(customerId);
      state = CustomerFormState(customer: customer);
    } catch (e) {
      state = CustomerFormState(error: e.toString());
    }
  }

  Future<void> saveCustomer({
    String? customerId,
    required String name,
    String? code,
    String? email,
    String? phone,
    String? mobile,
    String? taxNumber,
    required String customerType,
    String? priceListId,
    required double creditLimit,
    String? address,
    String? shippingAddress,
  }) async {
    state = CustomerFormState(isLoading: true, customer: state.customer);

    try {
      final organization = ref.read(currentOrganizationProvider);
      if (organization == null) {
        throw Exception('No organization selected');
      }

      if (customerId != null) {
        // Update existing customer
        await _customerService.updateCustomer(
          customerId: customerId,
          name: name,
          code: code,
          email: email,
          phone: phone,
          mobile: mobile,
          taxNumber: taxNumber,
          customerType: customerType,
          priceListId: priceListId,
          creditLimit: creditLimit,
          address: address,
          shippingAddress: shippingAddress,
        );
      } else {
        // Create new customer
        await _customerService.createCustomer(
          organizationId: organization.id,
          name: name,
          code: code,
          email: email,
          phone: phone,
          mobile: mobile,
          taxNumber: taxNumber,
          customerType: customerType,
          priceListId: priceListId,
          creditLimit: creditLimit,
          address: address,
          shippingAddress: shippingAddress,
        );
      }

      state = CustomerFormState();
    } catch (e) {
      state = CustomerFormState(error: e.toString(), customer: state.customer);
      rethrow;
    }
  }
}

class CustomerFormPage extends ConsumerStatefulWidget {
  final String? customerId;

  const CustomerFormPage({
    super.key,
    this.customerId,
  });

  @override
  ConsumerState<CustomerFormPage> createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends ConsumerState<CustomerFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _mobileController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _creditLimitController = TextEditingController(text: '0');
  final _addressController = TextEditingController();
  final _shippingAddressController = TextEditingController();
  
  String _customerType = 'retail';
  bool _useAddressForShipping = true;

  @override
  void initState() {
    super.initState();
    if (widget.customerId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(customerFormProvider.notifier).loadCustomer(widget.customerId!);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _mobileController.dispose();
    _taxNumberController.dispose();
    _creditLimitController.dispose();
    _addressController.dispose();
    _shippingAddressController.dispose();
    super.dispose();
  }

  void _populateForm(Customer customer) {
    _nameController.text = customer.name;
    _codeController.text = customer.code ?? '';
    _emailController.text = customer.email ?? '';
    _phoneController.text = customer.phone ?? '';
    _mobileController.text = customer.mobile ?? '';
    _taxNumberController.text = customer.taxNumber ?? '';
    _creditLimitController.text = customer.creditLimit.toString();
    _addressController.text = customer.address ?? '';
    _shippingAddressController.text = customer.shippingAddress ?? '';
    _customerType = customer.customerType;
    _useAddressForShipping = customer.address == customer.shippingAddress;
  }

  Future<void> _saveCustomer() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await ref.read(customerFormProvider.notifier).saveCustomer(
        customerId: widget.customerId,
        name: _nameController.text.trim(),
        code: _codeController.text.trim().isEmpty ? null : _codeController.text.trim(),
        email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        mobile: _mobileController.text.trim().isEmpty ? null : _mobileController.text.trim(),
        taxNumber: _taxNumberController.text.trim().isEmpty ? null : _taxNumberController.text.trim(),
        customerType: _customerType,
        creditLimit: double.tryParse(_creditLimitController.text) ?? 0,
        address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
        shippingAddress: _useAddressForShipping
            ? _addressController.text.trim()
            : _shippingAddressController.text.trim().isEmpty
                ? null
                : _shippingAddressController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.customerId != null
                  ? 'Customer updated successfully'
                  : 'Customer created successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerFormProvider);

    // Update form when customer loads
    ref.listen<CustomerFormState>(
      customerFormProvider,
      (previous, next) {
        if (next.customer != null && previous?.customer == null) {
          _populateForm(next.customer!);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerId != null ? 'Edit Customer' : 'New Customer'),
        actions: [
          if (!state.isLoading)
            TextButton(
              onPressed: _saveCustomer,
              child: const Text('Save'),
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('Error: ${state.error}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (widget.customerId != null) {
                            ref.read(customerFormProvider.notifier).loadCustomer(widget.customerId!);
                          }
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Basic Information
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Basic Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Customer Name *',
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter customer name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _codeController,
                                  decoration: const InputDecoration(
                                    labelText: 'Customer Code',
                                    prefixIcon: Icon(Icons.qr_code),
                                    helperText: 'Leave empty to auto-generate',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  value: _customerType,
                                  decoration: const InputDecoration(
                                    labelText: 'Customer Type',
                                    prefixIcon: Icon(Icons.category),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'retail',
                                      child: Text('Retail'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'wholesale',
                                      child: Text('Wholesale'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'distributor',
                                      child: Text('Distributor'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() => _customerType = value!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Contact Information
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Contact Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid email';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone',
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _mobileController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    labelText: 'Mobile',
                                    prefixIcon: Icon(Icons.smartphone),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Financial Information
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Financial Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _taxNumberController,
                                  decoration: const InputDecoration(
                                    labelText: 'Tax Number',
                                    prefixIcon: Icon(Icons.receipt),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _creditLimitController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Credit Limit',
                                    prefixIcon: Icon(Icons.credit_card),
                                    suffixText: '\$',
                                  ),
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      if (double.tryParse(value) == null) {
                                        return 'Please enter a valid number';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Address Information
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Address Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _addressController,
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    labelText: 'Billing Address',
                                    prefixIcon: Icon(Icons.location_on),
                                    alignLabelWithHint: true,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                CheckboxListTile(
                                  value: _useAddressForShipping,
                                  onChanged: (value) {
                                    setState(() => _useAddressForShipping = value ?? true);
                                  },
                                  title: const Text('Use billing address for shipping'),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                                if (!_useAddressForShipping) ...[
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: _shippingAddressController,
                                    maxLines: 3,
                                    decoration: const InputDecoration(
                                      labelText: 'Shipping Address',
                                      prefixIcon: Icon(Icons.local_shipping),
                                      alignLabelWithHint: true,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Save Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state.isLoading ? null : _saveCustomer,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Text(
                              widget.customerId != null ? 'Update Customer' : 'Create Customer',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
    );
  }
}