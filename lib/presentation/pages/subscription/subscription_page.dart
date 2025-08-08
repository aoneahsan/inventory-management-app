import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/organization.dart';
import '../../../services/payment/stripe_service.dart';
import '../../providers/auth_provider.dart';

final stripeServiceProvider = Provider<StripeService>((ref) {
  return StripeService();
});

final subscriptionDetailsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final stripeService = ref.watch(stripeServiceProvider);
  return stripeService.getSubscriptionDetails(org.id);
});

final invoicesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final stripeService = ref.watch(stripeServiceProvider);
  return stripeService.getInvoices(org.id);
});

class SubscriptionPage extends ConsumerStatefulWidget {
  final SubscriptionTier? targetTier;
  
  const SubscriptionPage({
    super.key,
    this.targetTier,
  });

  @override
  ConsumerState<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends ConsumerState<SubscriptionPage> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final organization = ref.watch(currentOrganizationProvider);
    final user = ref.watch(currentUserProvider);
    
    if (organization == null || user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Subscription')),
        body: const Center(child: Text('No organization found')),
      );
    }

    final isOwner = user.isOrganizationOwner;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Subscription Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Plans', icon: Icon(Icons.rocket_launch)),
              Tab(text: 'Billing', icon: Icon(Icons.credit_card)),
              Tab(text: 'Invoices', icon: Icon(Icons.receipt)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPlansTab(organization, isOwner),
            _buildBillingTab(organization, isOwner),
            _buildInvoicesTab(organization),
          ],
        ),
      ),
    );
  }

  Widget _buildPlansTab(Organization organization, bool canManage) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose the Right Plan for Your Business',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Upgrade or downgrade at any time. No hidden fees.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),
          _buildPlanCard(
            tier: SubscriptionTier.free,
            currentTier: organization.tier,
            canManage: canManage,
          ),
          const SizedBox(height: 16),
          _buildPlanCard(
            tier: SubscriptionTier.basic,
            currentTier: organization.tier,
            canManage: canManage,
            isPopular: true,
          ),
          const SizedBox(height: 16),
          _buildPlanCard(
            tier: SubscriptionTier.professional,
            currentTier: organization.tier,
            canManage: canManage,
          ),
          const SizedBox(height: 16),
          _buildPlanCard(
            tier: SubscriptionTier.enterprise,
            currentTier: organization.tier,
            canManage: canManage,
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required SubscriptionTier tier,
    required SubscriptionTier currentTier,
    required bool canManage,
    bool isPopular = false,
  }) {
    final isCurrentPlan = tier == currentTier;
    final price = StripeService.tierPrices[tier]!;
    
    return Card(
      elevation: isPopular ? 8 : 2,
      child: Container(
        decoration: BoxDecoration(
          border: isPopular
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            if (isPopular)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: const Text(
                  'MOST POPULAR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tier.name.toUpperCase(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      if (isCurrentPlan)
                        Chip(
                          label: const Text('Current Plan'),
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$$price',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Text(' / month', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ..._getPlanFeatures(tier).map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(feature)),
                          ],
                        ),
                      )),
                  const SizedBox(height: 24),
                  if (canManage)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isCurrentPlan || _isProcessing
                            ? null
                            : () => _handlePlanChange(tier),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          isCurrentPlan
                              ? 'Current Plan'
                              : tier.index < currentTier.index
                                  ? 'Downgrade'
                                  : 'Upgrade',
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingTab(Organization organization, bool canManage) {
    final subscriptionAsync = ref.watch(subscriptionDetailsProvider);
    
    return subscriptionAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (subscription) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Subscription',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Plan'),
                        trailing: Text(
                          subscription['tier'].toString().toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Status'),
                        trailing: Chip(
                          label: Text(subscription['status'].toString().toUpperCase()),
                          backgroundColor: subscription['status'] == 'active'
                              ? Colors.green.shade100
                              : Colors.orange.shade100,
                        ),
                      ),
                      if (subscription['currentPeriodEnd'] != null)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Next Billing Date'),
                          trailing: Text(
                            _formatDate(subscription['currentPeriodEnd']),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Amount'),
                        trailing: Text(
                          '\$${subscription['amount']} / ${subscription['interval']}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (canManage && organization.tier != SubscriptionTier.free)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Method',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.credit_card),
                          title: const Text('•••• •••• •••• 4242'),
                          subtitle: const Text('Expires 12/25'),
                          trailing: TextButton(
                            onPressed: _handleUpdatePaymentMethod,
                            child: const Text('Update'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              if (canManage && organization.tier != SubscriptionTier.free)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Danger Zone',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.red,
                              ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Cancelling your subscription will downgrade your organization to the free plan at the end of the current billing period.',
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: _handleCancelSubscription,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                          child: const Text('Cancel Subscription'),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInvoicesTab(Organization organization) {
    final invoicesAsync = ref.watch(invoicesProvider);
    
    return invoicesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (invoices) {
        if (invoices.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No invoices yet'),
              ],
            ),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: invoices.length,
          itemBuilder: (context, index) {
            final invoice = invoices[index];
            final amount = (invoice['amount'] as int) / 100;
            final date = DateTime.fromMillisecondsSinceEpoch(
              invoice['created'] * 1000,
            );
            
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.receipt),
                ),
                title: Text(invoice['number']),
                subtitle: Text(_formatDate(date.toIso8601String())),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$$amount',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () => _downloadInvoice(invoice['invoicePdf']),
                      tooltip: 'Download PDF',
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<String> _getPlanFeatures(SubscriptionTier tier) {
    switch (tier) {
      case SubscriptionTier.free:
        return [
          'Up to 3 team members',
          '100 products',
          'Basic inventory tracking',
          'Standard reports',
          'Email support',
        ];
      case SubscriptionTier.basic:
        return [
          'Up to 10 team members',
          '1,000 products',
          'Advanced inventory tracking',
          'Custom reports',
          'Priority email support',
          'Barcode scanning',
          'Multi-warehouse',
        ];
      case SubscriptionTier.professional:
        return [
          'Up to 50 team members',
          '10,000 products',
          'All Basic features',
          'API access',
          'Advanced analytics',
          'Phone support',
          'Custom roles',
          'Bulk operations',
        ];
      case SubscriptionTier.enterprise:
        return [
          'Unlimited team members',
          'Unlimited products',
          'All Professional features',
          'Dedicated account manager',
          '24/7 phone support',
          'Custom integrations',
          'SLA guarantee',
          'Advanced security',
        ];
    }
  }

  String _formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _handlePlanChange(SubscriptionTier newTier) async {
    setState(() => _isProcessing = true);
    
    try {
      final org = ref.read(currentOrganizationProvider)!;
      final user = ref.read(currentUserProvider)!;
      final stripeService = ref.read(stripeServiceProvider);
      
      if (newTier == SubscriptionTier.free) {
        // Downgrade to free
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Downgrade to Free Plan'),
            content: const Text(
              'Are you sure you want to downgrade to the free plan? '
              'You will lose access to premium features.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Downgrade'),
              ),
            ],
          ),
        );
        
        if (confirmed == true) {
          await stripeService.cancelSubscription(org.id);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Subscription cancelled. You will be downgraded at the end of the billing period.'),
              ),
            );
          }
        }
      } else {
        // Upgrade/change plan
        final checkoutUrl = await stripeService.createCheckoutSession(
          organizationId: org.id,
          userId: user.id,
          tier: newTier,
          successUrl: '${Uri.base.origin}/billing/success',
          cancelUrl: '${Uri.base.origin}/billing',
        );
        
        // Launch the Stripe checkout URL
        if (mounted) {
          final uri = Uri.parse(checkoutUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.platformDefault);
          } else {
            throw 'Could not launch checkout URL';
          }
        }
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
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _handleUpdatePaymentMethod() async {
    try {
      final org = ref.read(currentOrganizationProvider)!;
      final stripeService = ref.read(stripeServiceProvider);
      
      // Open Stripe billing portal
      await stripeService.createBillingPortalSession(
        organizationId: org.id,
        returnUrl: Uri.base.origin,
      );
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

  Future<void> _handleCancelSubscription() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Subscription'),
        content: const Text(
          'Are you sure you want to cancel your subscription? '
          'You will lose access to premium features at the end of the billing period.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep Subscription'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Cancel Subscription'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      try {
        final org = ref.read(currentOrganizationProvider)!;
        final stripeService = ref.read(stripeServiceProvider);
        await stripeService.cancelSubscription(org.id);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Subscription cancelled. You will retain access until the end of the billing period.'),
            ),
          );
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
  }

  Future<void> _downloadInvoice(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading invoice: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}