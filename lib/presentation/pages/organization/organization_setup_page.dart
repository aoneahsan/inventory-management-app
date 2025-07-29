import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/errors/exceptions.dart';
import '../../providers/auth_provider.dart';
import '../../router/app_router.dart';

class OrganizationSetupPage extends ConsumerStatefulWidget {
  const OrganizationSetupPage({super.key});

  @override
  ConsumerState<OrganizationSetupPage> createState() => _OrganizationSetupPageState();
}

class _OrganizationSetupPageState extends ConsumerState<OrganizationSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _organizationNameController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  bool _isCreatingNew = true;

  @override
  void dispose() {
    _organizationNameController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleCreateOrganization() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref.read(organizationNotifierProvider.notifier).createOrganization(
            name: _organizationNameController.text.trim(),
          );
    }
  }

  Future<void> _handleJoinOrganization() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref.read(organizationNotifierProvider.notifier).joinOrganization(
            _inviteCodeController.text.trim(),
          );
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orgState = ref.watch(organizationNotifierProvider);
    final user = ref.watch(currentUserProvider);

    // Listen for organization state changes
    ref.listen<AsyncValue<void>>(organizationNotifierProvider, (previous, next) {
      next.when(
        data: (_) {
          // Organization created/joined successfully
          context.go(AppRouter.home);
        },
        loading: () {},
        error: (error, _) {
          String message = 'Operation failed';
          if (error is AuthException || error is BusinessException) {
            message = error.toString();
          }
          _showErrorMessage(message);
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Setup'),
        centerTitle: true,
        actions: [
          // Sign out button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).signOut();
              if (context.mounted) {
                context.go(AppRouter.login);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.business,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome, ${user?.name ?? 'User'}!',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'To get started, create a new organization or join an existing one.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                
                // Toggle buttons
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: true,
                      label: Text('Create New'),
                      icon: Icon(Icons.add_business),
                    ),
                    ButtonSegment(
                      value: false,
                      label: Text('Join Existing'),
                      icon: Icon(Icons.group_add),
                    ),
                  ],
                  selected: {_isCreatingNew},
                  onSelectionChanged: (selection) {
                    setState(() {
                      _isCreatingNew = selection.first;
                      _formKey.currentState?.reset();
                    });
                  },
                ),
                const SizedBox(height: 24),

                Form(
                  key: _formKey,
                  child: _isCreatingNew
                      ? Column(
                          children: [
                            TextFormField(
                              controller: _organizationNameController,
                              decoration: const InputDecoration(
                                labelText: 'Organization Name',
                                prefixIcon: Icon(Icons.business),
                                border: OutlineInputBorder(),
                                helperText: 'Choose a name for your organization',
                              ),
                              enabled: !orgState.isLoading,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter organization name';
                                }
                                if (value.length < 3) {
                                  return 'Name must be at least 3 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: orgState.isLoading 
                                  ? null 
                                  : _handleCreateOrganization,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: orgState.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Text(
                                      'Create Organization',
                                      style: TextStyle(fontSize: 16),
                                    ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            TextFormField(
                              controller: _inviteCodeController,
                              decoration: const InputDecoration(
                                labelText: 'Invite Code',
                                prefixIcon: Icon(Icons.vpn_key),
                                border: OutlineInputBorder(),
                                helperText: 'Enter the invite code from your organization',
                              ),
                              enabled: !orgState.isLoading,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter invite code';
                                }
                                if (value.length < 6) {
                                  return 'Invalid invite code';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: orgState.isLoading 
                                  ? null 
                                  : _handleJoinOrganization,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: orgState.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Text(
                                      'Join Organization',
                                      style: TextStyle(fontSize: 16),
                                    ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 48),
                
                // Info card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Free Plan Features',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('• Up to 3 team members'),
                        const Text('• 100 products'),
                        const Text('• Basic inventory tracking'),
                        const Text('• Standard reports'),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            // TODO: Show pricing page
                          },
                          child: const Text('View all plans'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}