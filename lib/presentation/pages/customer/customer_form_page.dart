import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Removed unused import: '../../../domain/entities/customer.dart'
import '../../../core/errors/exceptions.dart';
import '../../providers/auth_provider.dart';
import 'customers_page.dart';

class CustomerFormPage extends ConsumerStatefulWidget {
  final String? customerId;

  const CustomerFormPage({super.key, this.customerId});

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
  final _addressController = TextEditingController();
  final _shippingAddressController = TextEditingController();
  final _creditLimitController = TextEditingController(text: '0');
  
  String _customerType = 'retail';
  bool _isLoading = false;
  bool _useAddressForShipping = true;

  @override
  void initState() {
    super.initState();
    if (widget.customerId != null) {
      _loadCustomer();
    }
  }

  Future<void> _loadCustomer() async {
    setState(() => _isLoading = true);
    try {
      final customerService = ref.read(customerServiceProvider);
      final customer = await customerService.getCustomer(widget.customerId!);
      
      if (customer != null) {
        setState(() {
          _nameController.text = customer.name;
          _codeController.text = customer.code ?? '';
          _emailController.text = customer.email ?? '';
          _phoneController.text = customer.phone ?? '';
          _mobileController.text = customer.mobile ?? '';
          _taxNumberController.text = customer.taxNumber ?? '';
          _addressController.text = customer.address ?? '';
          _shippingAddressController.text = customer.shippingAddress ?? '';
          _creditLimitController.text = customer.creditLimit.toString();
          _customerType = customer.customerType;
          _useAddressForShipping = customer.address == customer.shippingAddress;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading customer: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
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
    _addressController.dispose();
    _shippingAddressController.dispose();
    _creditLimitController.dispose();
    super.dispose();
  }

  Future<void> _saveCustomer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final customerService = ref.read(customerServiceProvider);
      final org = ref.read(currentOrganizationProvider);
      
      if (org == null) throw BusinessException(message: 'No organization');

      if (widget.customerId != null) {
        // Update existing customer
        await customerService.updateCustomer(
          customerId: widget.customerId!,
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
              : (_shippingAddressController.text.trim().isEmpty ? null : _shippingAddressController.text.trim()),
        );
      } else {
        // Create new customer
        await customerService.createCustomer(
          organizationId: org.id,
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
              : (_shippingAddressController.text.trim().isEmpty ? null : _shippingAddressController.text.trim()),
        );
      }

      ref.invalidate(customersProvider);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.customerId != null 
                  ? 'Customer updated successfully' 
                  : 'Customer created successfully'
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerId != null ? 'Edit Customer' : 'New Customer'),
      ),
      body: _isLoading && widget.customerId != null
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Basic Information Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Basic Information',
                            style: Theme.of(context).textTheme.titleLarge,
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
                          
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _codeController,
                                  decoration: const InputDecoration(
                                    labelText: 'Customer Code',
                                    prefixIcon: Icon(Icons.tag),
                                    helperText: 'Leave empty for auto-generate',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _customerType,
                                  decoration: const InputDecoration(
                                    labelText: 'Customer Type',
                                    prefixIcon: Icon(Icons.category),
                                  ),
                                  items: const [
                                    DropdownMenuItem(value: 'retail', child: Text('Retail')),
                                    DropdownMenuItem(value: 'wholesale', child: Text('Wholesale')),
                                    DropdownMenuItem(value: 'corporate', child: Text('Corporate')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _customerType = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Contact Information Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Information',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _phoneController,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone',
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _mobileController,
                                  decoration: const InputDecoration(
                                    labelText: 'Mobile',
                                    prefixIcon: Icon(Icons.smartphone),
                                  ),
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Business Information Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Business Information',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _taxNumberController,
                                  decoration: const InputDecoration(
                                    labelText: 'Tax Number',
                                    prefixIcon: Icon(Icons.receipt),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _creditLimitController,
                                  decoration: const InputDecoration(
                                    labelText: 'Credit Limit',
                                    prefixIcon: Icon(Icons.credit_card),
                                    prefixText: '\$',
                                  ),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Address Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address Information',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          
                          TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              labelText: 'Billing Address',
                              prefixIcon: Icon(Icons.location_on),
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          
                          CheckboxListTile(
                            title: const Text('Use billing address for shipping'),
                            value: _useAddressForShipping,
                            onChanged: (value) {
                              setState(() {
                                _useAddressForShipping = value!;
                              });
                            },
                          ),
                          
                          if (!_useAddressForShipping) ...[
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _shippingAddressController,
                              decoration: const InputDecoration(
                                labelText: 'Shipping Address',
                                prefixIcon: Icon(Icons.local_shipping),
                              ),
                              maxLines: 3,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _isLoading ? null : () => context.pop(),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveCustomer,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text(widget.customerId != null ? 'Update' : 'Create'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
}