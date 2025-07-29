import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/branch.dart';
import '../../../services/branch/branch_service.dart';
import '../../providers/organization_provider.dart';

class BranchFormPage extends ConsumerStatefulWidget {
  final String? branchId;

  const BranchFormPage({
    super.key,
    this.branchId,
  });

  @override
  ConsumerState<BranchFormPage> createState() => _BranchFormPageState();
}

class _BranchFormPageState extends ConsumerState<BranchFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  
  BranchType _selectedType = BranchType.store;
  bool _isActive = true;
  bool _isDefault = false;
  bool _isLoading = false;
  
  Branch? _existingBranch;

  @override
  void initState() {
    super.initState();
    if (widget.branchId != null) {
      _loadBranch();
    }
  }

  Future<void> _loadBranch() async {
    try {
      setState(() => _isLoading = true);
      final branchService = BranchService();
      final branch = await branchService.getBranch(widget.branchId!);
      
      if (branch != null) {
        setState(() {
          _existingBranch = branch;
          _nameController.text = branch.name;
          _codeController.text = branch.code;
          _addressController.text = branch.address ?? '';
          _cityController.text = branch.city ?? '';
          _stateController.text = branch.state ?? '';
          _postalCodeController.text = branch.postalCode ?? '';
          _phoneController.text = branch.phone ?? '';
          _emailController.text = branch.email ?? '';
          _selectedType = branch.type;
          _isActive = branch.isActive;
          _isDefault = branch.isDefault;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading branch: $e')),
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
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.branchId == null ? 'New Branch' : 'Edit Branch'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Basic Information',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Branch Name*',
                                hintText: 'e.g., Main Store, Central Warehouse',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter branch name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _codeController,
                              decoration: const InputDecoration(
                                labelText: 'Branch Code',
                                hintText: 'e.g., BR001, WH001',
                              ),
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<BranchType>(
                              value: _selectedType,
                              decoration: const InputDecoration(
                                labelText: 'Branch Type*',
                              ),
                              items: BranchType.values.map((type) {
                                return DropdownMenuItem(
                                  value: type,
                                  child: Row(
                                    children: [
                                      Icon(_getTypeIcon(type), size: 20),
                                      const SizedBox(width: 8),
                                      Text(type.displayName),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _selectedType = value);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Location Details',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _addressController,
                              decoration: const InputDecoration(
                                labelText: 'Address',
                                hintText: 'Street address',
                              ),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _cityController,
                                    decoration: const InputDecoration(
                                      labelText: 'City',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _stateController,
                                    decoration: const InputDecoration(
                                      labelText: 'State',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _postalCodeController,
                              decoration: const InputDecoration(
                                labelText: 'Postal Code',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contact Information',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Settings',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            SwitchListTile(
                              title: const Text('Active'),
                              subtitle: const Text('Enable operations at this branch'),
                              value: _isActive,
                              onChanged: (value) {
                                setState(() => _isActive = value);
                              },
                            ),
                            SwitchListTile(
                              title: const Text('Default Branch'),
                              subtitle: const Text('Set as default for new transactions'),
                              value: _isDefault,
                              onChanged: (value) {
                                setState(() => _isDefault = value);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => context.pop(),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FilledButton(
                            onPressed: _saveBranch,
                            child: Text(widget.branchId == null ? 'Create' : 'Update'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  IconData _getTypeIcon(BranchType type) {
    switch (type) {
      case BranchType.store:
        return Icons.store;
      case BranchType.warehouse:
        return Icons.warehouse;
      case BranchType.both:
        return Icons.business;
    }
  }

  Future<void> _saveBranch() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final organizationId = ref.read(currentOrganizationIdProvider);
      if (organizationId == null) {
        throw Exception('No organization selected');
      }

      final branch = Branch(
        id: widget.branchId ?? '',
        organizationId: organizationId,
        name: _nameController.text.trim(),
        code: _codeController.text.trim(),
        type: _selectedType,
        address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
        city: _cityController.text.trim().isEmpty ? null : _cityController.text.trim(),
        state: _stateController.text.trim().isEmpty ? null : _stateController.text.trim(),
        postalCode: _postalCodeController.text.trim().isEmpty ? null : _postalCodeController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        isActive: _isActive,
        isDefault: _isDefault,
        createdAt: _existingBranch?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final branchService = BranchService();
      
      if (widget.branchId == null) {
        await branchService.createBranch(branch);
      } else {
        await branchService.updateBranch(widget.branchId!, branch);
      }

      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.branchId == null
                  ? 'Branch created successfully'
                  : 'Branch updated successfully',
            ),
          ),
        );
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
}