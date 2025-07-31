import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdvancedFeaturesPage extends StatelessWidget {
  const AdvancedFeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Features'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeatureCard(
            context,
            title: 'Serial & Batch Tracking',
            subtitle: 'Track individual items and batches with expiry dates',
            icon: Icons.qr_code_2,
            color: Colors.blue,
            onTap: () => context.push('/tracking'),
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            title: 'Tax Management',
            subtitle: 'Configure GST, VAT and custom tax rates',
            icon: Icons.receipt_long,
            color: Colors.green,
            onTap: () => context.push('/tax-rates'),
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            title: 'Composite Items',
            subtitle: 'Manage bundles and kits with multiple components',
            icon: Icons.widgets,
            color: Colors.orange,
            onTap: () => context.push('/composite-items'),
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            title: 'Repackaging',
            subtitle: 'Convert bulk items to smaller units',
            icon: Icons.transform,
            color: Colors.purple,
            onTap: () => context.push('/repackaging'),
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            title: 'Communication Templates',
            subtitle: 'SMS, Email and WhatsApp message templates',
            icon: Icons.message,
            color: Colors.teal,
            onTap: () => context.push('/communication'),
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            title: 'Scheduled Reports',
            subtitle: 'Automate report generation and distribution',
            icon: Icons.schedule,
            color: Colors.indigo,
            onTap: () => context.push('/scheduled-reports'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}