import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/supplier.dart';
import '../../../services/purchase/supplier_service.dart';
import '../../../services/database/database.dart';
import '../../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';

final supplierFormProvider = StateNotifierProvider.autoDispose<SupplierFormNotifier, SupplierFormState>((ref) {
  return SupplierFormNotifier(
    supplierService: SupplierService(database: AppDatabase.instance),
  );
});

class SupplierFormState {
  final bool isLoading;
  final String? error;
  final Supplier? supplier;

  SupplierFormState({
    this.isLoading = false,
    this.error,
    this.supplier,
  });
}

class SupplierFormNotifier extends StateNotifier<SupplierFormState> {
  final SupplierService supplierService;

  SupplierFormNotifier({required this.supplierService}) : super(SupplierFormState());

  Future<void> loadSupplier(String supplierId) async {
    state = SupplierFormState(isLoading: true);
    try {
      final supplier = await supplierService.getSupplierById(supplierId);
      state = SupplierFormState(supplier: supplier);
    } catch (e) {
      state = SupplierFormState(error: e.toString());
    }
  }

  Future<bool> saveSupplier({
    required String organizationId,
    required String name,
    String? code,
    String? email,
    String? phone,
    String? mobile,
    String? website,
    String? taxNumber,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    required int paymentTerms,
    required double creditLimit,
    String? notes,
    String? supplierId,
  }) async {
    state = SupplierFormState(isLoading: true);
    try {
      if (supplierId != null) {
        // Update existing supplier
        await supplierService.updateSupplier(supplierId, {
          'name': name,
          'code': code,
          'email': email,
          'phone': phone,
          'mobile': mobile,
          'website': website,
          'tax_number': taxNumber,
          'address': address,
          'city': city,
          'state': state,
          'country': country,
          'postal_code': postalCode,
          'payment_terms': paymentTerms,
          'credit_limit': creditLimit,
          'notes': notes,
        });
      } else {
        // Create new supplier
        final supplier = Supplier(
          id: '',
          organizationId: organizationId,
          name: name,
          code: code,
          email: email,
          phone: phone,
          mobile: mobile,
          website: website,
          taxNumber: taxNumber,
          address: address,
          city: city,
          state: state,
          country: country,
          postalCode: postalCode,
          paymentTerms: paymentTerms,
          creditLimit: creditLimit,
          currentBalance: 0,
          status: 'active',
          notes: notes,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await supplierService.createSupplier(supplier);
      }
      state = SupplierFormState();
      return true;
    } catch (e) {
      state = SupplierFormState(error: e.toString());
      return false;
    }
  }
}

class SupplierFormPage extends ConsumerStatefulWidget {
  final String? supplierId;

  const SupplierFormPage({super.key, this.supplierId});

  @override
  ConsumerState<SupplierFormPage> createState() => _SupplierFormPageState();
}

class _SupplierFormPageState extends ConsumerState<SupplierFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _mobileController = TextEditingController();
  final _websiteController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _paymentTermsController = TextEditingController(text: '30');
  final _creditLimitController = TextEditingController(text: '0');
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.supplierId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(supplierFormProvider.notifier).loadSupplier(widget.supplierId!);
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
    _websiteController.dispose();
    _taxNumberController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    _paymentTermsController.dispose();
    _creditLimitController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _populateForm(Supplier supplier) {
    _nameController.text = supplier.name;
    _codeController.text = supplier.code ?? '';
    _emailController.text = supplier.email ?? '';
    _phoneController.text = supplier.phone ?? '';
    _mobileController.text = supplier.mobile ?? '';
    _websiteController.text = supplier.website ?? '';
    _taxNumberController.text = supplier.taxNumber ?? '';
    _addressController.text = supplier.address ?? '';
    _cityController.text = supplier.city ?? '';
    _stateController.text = supplier.state ?? '';
    _countryController.text = supplier.country ?? '';
    _postalCodeController.text = supplier.postalCode ?? '';
    _paymentTermsController.text = supplier.paymentTerms.toString();
    _creditLimitController.text = supplier.creditLimit.toString();
    _notesController.text = supplier.notes ?? '';
  }

  Future<void> _saveSupplier() async {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    final success = await ref.read(supplierFormProvider.notifier).saveSupplier(
      organizationId: user.organizationId!,
      name: _nameController.text,
      code: _codeController.text.isEmpty ? null : _codeController.text,
      email: _emailController.text.isEmpty ? null : _emailController.text,
      phone: _phoneController.text.isEmpty ? null : _phoneController.text,
      mobile: _mobileController.text.isEmpty ? null : _mobileController.text,
      website: _websiteController.text.isEmpty ? null : _websiteController.text,
      taxNumber: _taxNumberController.text.isEmpty ? null : _taxNumberController.text,
      address: _addressController.text.isEmpty ? null : _addressController.text,
      city: _cityController.text.isEmpty ? null : _cityController.text,
      state: _stateController.text.isEmpty ? null : _stateController.text,
      country: _countryController.text.isEmpty ? null : _countryController.text,
      postalCode: _postalCodeController.text.isEmpty ? null : _postalCodeController.text,
      paymentTerms: int.tryParse(_paymentTermsController.text) ?? 30,
      creditLimit: double.tryParse(_creditLimitController.text) ?? 0,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      supplierId: widget.supplierId,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.supplierId != null ? 'Supplier updated' : 'Supplier created'),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(supplierFormProvider);

    ref.listen<SupplierFormState>(supplierFormProvider, (previous, next) {
      if (next.supplier != null && previous?.supplier == null) {
        _populateForm(next.supplier!);
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: Colors.red),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.supplierId != null ? 'Edit Supplier' : 'New Supplier'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Supplier Name *',
                        prefixIcon: Icon(Icons.business),
                      ),
                      validator: Validators.required('Supplier name is required'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        labelText: 'Supplier Code',
                        prefixIcon: Icon(Icons.qr_code),
                        hintText: 'Leave empty to auto-generate',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return Validators.email('Invalid email')(value);
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _paymentTermsController,
                            decoration: const InputDecoration(
                              labelText: 'Payment Terms (days)',
                              prefixIcon: Icon(Icons.calendar_today),
                            ),
                            keyboardType: TextInputType.number,
                            validator: Validators.required('Payment terms required'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _creditLimitController,
                            decoration: const InputDecoration(
                              labelText: 'Credit Limit',
                              prefixIcon: Icon(Icons.account_balance_wallet),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 16),
                        FilledButton(
                          onPressed: state.isLoading ? null : _saveSupplier,
                          child: Text(widget.supplierId != null ? 'Update' : 'Create'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}