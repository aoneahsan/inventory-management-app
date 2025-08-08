import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/organization.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/auth/forgot_password_page.dart';
import '../pages/organization/organization_setup_page.dart';
import '../pages/organization/organization_settings_page.dart';
import '../pages/subscription/subscription_page.dart';
import '../pages/inventory/product_details_page.dart';
import '../pages/inventory/product_form_page.dart';
import '../pages/home/home_page.dart';
import '../pages/splash/splash_page.dart';
import '../pages/onboarding/onboarding_page.dart';
import '../pages/onboarding/feature_tour_page.dart';
import '../pages/pos/pos_main_page.dart';
import '../pages/pos/checkout_page.dart';
import '../pages/pos/pos_reports_page.dart';
import '../pages/suppliers/suppliers_page.dart';
import '../pages/suppliers/supplier_form_page.dart';
import '../pages/purchase_orders/purchase_orders_page.dart';
import '../pages/purchase_orders/purchase_order_form_page.dart';
import '../pages/purchase_orders/purchase_order_details_page.dart';
import '../pages/branch/branches_page.dart';
import '../pages/branch/branch_form_page.dart';
import '../pages/transfer/stock_transfers_page.dart';
import '../pages/advanced/advanced_features_page.dart';
import '../pages/tracking/serial_batch_page.dart';
import '../pages/tax/tax_rates_page.dart';
import '../pages/composite/composite_items_page.dart';
import '../pages/repackaging/repackaging_page.dart';
import '../pages/communication/communication_templates_page.dart';
import '../pages/reporting/scheduled_reports_page.dart';
import '../pages/notifications/notifications_page.dart';
import '../pages/settings/notification_settings_page.dart';
import '../pages/export/data_export_page.dart';
import '../pages/analytics/analytics_charts_page.dart';
import '../pages/backup/backup_restore_page.dart';
import '../pages/audit/audit_logs_page.dart';
import 'router_notifier.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String organizationSetup = '/organization/setup';
  static const String organizationSettings = '/organization/settings';
  static const String subscription = '/subscription';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String featureTour = '/feature-tour';
  static const String pos = '/pos';
  static const String posCheckout = '/pos/checkout';
  static const String posRegister = '/pos/register';
  static const String posReports = '/pos/reports';
  static const String suppliers = '/suppliers';
  static const String supplierDetails = '/suppliers/:id';
  static const String supplierNew = '/suppliers/new';
  static const String supplierEdit = '/suppliers/:id/edit';
  static const String purchaseOrders = '/purchase-orders';
  static const String purchaseOrderNew = '/purchase-orders/new';
  static const String purchaseOrderDetails = '/purchase-orders/:id';
  static const String branches = '/branches';
  static const String branchNew = '/branches/new';
  static const String branchEdit = '/branches/:id';
  static const String transfers = '/transfers';
  static const String transferNew = '/transfers/new';
  static const String transferDetails = '/transfers/:id';
  static const String advancedFeatures = '/advanced';
  static const String tracking = '/tracking';
  static const String taxRates = '/tax-rates';
  static const String compositeItems = '/composite-items';
  static const String repackaging = '/repackaging';
  static const String communication = '/communication';
  static const String scheduledReports = '/scheduled-reports';
  static const String notifications = '/notifications';
  static const String notificationSettings = '/settings/notifications';
  static const String dataExport = '/export';
  static const String analyticsCharts = '/analytics/charts';
  static const String backupRestore = '/backup';
  static const String auditLogs = '/audit';

  static GoRouter router(Ref ref) {
    final routerNotifier = ref.watch(routerNotifierProvider);

    return GoRouter(
      initialLocation: splash,
      refreshListenable: routerNotifier,
      redirect: routerNotifier.redirect,
      routes: [
        GoRoute(
          path: splash,
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        // Auth routes (accessible only when not authenticated)
        GoRoute(
          path: login,
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: register,
          name: 'register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: forgotPassword,
          name: 'forgotPassword',
          builder: (context, state) => const ForgotPasswordPage(),
        ),
        // Onboarding routes
        GoRoute(
          path: onboarding,
          name: 'onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: featureTour,
          name: 'featureTour',
          builder: (context, state) => const FeatureTourPage(),
        ),
        // Protected routes (require authentication)
        GoRoute(
          path: organizationSetup,
          name: 'organizationSetup',
          builder: (context, state) => const OrganizationSetupPage(),
        ),
        GoRoute(
          path: organizationSettings,
          name: 'organizationSettings',
          builder: (context, state) => const OrganizationSettingsPage(),
        ),
        GoRoute(
          path: subscription,
          name: 'subscription',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return SubscriptionPage(
              targetTier: extra?['targetTier'] as SubscriptionTier?,
            );
          },
        ),
        GoRoute(
          path: home,
          name: 'home',
          builder: (context, state) => const HomePage(),
          routes: [
            // Nested routes under home
            GoRoute(
              path: 'products/new',
              name: 'createProduct',
              builder: (context, state) => const ProductFormPage(),
            ),
            GoRoute(
              path: 'products/:id',
              name: 'productDetails',
              builder: (context, state) {
                final productId = state.pathParameters['id']!;
                return ProductDetailsPage(productId: productId);
              },
            ),
            GoRoute(
              path: 'products/:id/edit',
              name: 'editProduct',
              builder: (context, state) {
                final productId = state.pathParameters['id']!;
                return ProductFormPage(productId: productId);
              },
            ),
          ],
        ),
        // POS routes
        GoRoute(
          path: pos,
          name: 'pos',
          builder: (context, state) => const POSMainPage(),
        ),
        GoRoute(
          path: posCheckout,
          name: 'posCheckout',
          builder: (context, state) => const CheckoutPage(),
        ),
        GoRoute(
          path: posReports,
          name: 'posReports',
          builder: (context, state) => const POSReportsPage(),
        ),
        // Supplier routes
        GoRoute(
          path: suppliers,
          name: 'suppliers',
          builder: (context, state) => const SuppliersPage(),
        ),
        GoRoute(
          path: supplierNew,
          name: 'supplierNew',
          builder: (context, state) => const SupplierFormPage(),
        ),
        GoRoute(
          path: supplierEdit,
          name: 'supplierEdit',
          builder: (context, state) {
            final supplierId = state.pathParameters['id']!;
            return SupplierFormPage(supplierId: supplierId);
          },
        ),
        // Purchase Order routes
        GoRoute(
          path: purchaseOrders,
          name: 'purchaseOrders',
          builder: (context, state) => const PurchaseOrdersPage(),
        ),
        GoRoute(
          path: purchaseOrderNew,
          name: 'purchaseOrderNew',
          builder: (context, state) => const PurchaseOrderFormPage(),
        ),
        GoRoute(
          path: purchaseOrderDetails,
          name: 'purchaseOrderDetails',
          builder: (context, state) {
            final orderId = state.pathParameters['id']!;
            return PurchaseOrderDetailsPage(purchaseOrderId: orderId);
          },
        ),
        // Branch routes
        GoRoute(
          path: branches,
          name: 'branches',
          builder: (context, state) => const BranchesPage(),
        ),
        GoRoute(
          path: branchNew,
          name: 'branchNew',
          builder: (context, state) => const BranchFormPage(),
        ),
        GoRoute(
          path: branchEdit,
          name: 'branchEdit',
          builder: (context, state) {
            final branchId = state.pathParameters['id']!;
            return BranchFormPage(branchId: branchId);
          },
        ),
        // Transfer routes
        GoRoute(
          path: transfers,
          name: 'transfers',
          builder: (context, state) => const StockTransfersPage(),
        ),
        // Advanced features
        GoRoute(
          path: advancedFeatures,
          name: 'advancedFeatures',
          builder: (context, state) => const AdvancedFeaturesPage(),
        ),
        GoRoute(
          path: tracking,
          name: 'tracking',
          builder: (context, state) => const SerialBatchPage(),
        ),
        GoRoute(
          path: taxRates,
          name: 'taxRates',
          builder: (context, state) => const TaxRatesPage(),
        ),
        GoRoute(
          path: compositeItems,
          name: 'compositeItems',
          builder: (context, state) => const CompositeItemsPage(),
        ),
        GoRoute(
          path: repackaging,
          name: 'repackaging',
          builder: (context, state) => const RepackagingPage(),
        ),
        GoRoute(
          path: communication,
          name: 'communication',
          builder: (context, state) => const CommunicationTemplatesPage(),
        ),
        GoRoute(
          path: scheduledReports,
          name: 'scheduledReports',
          builder: (context, state) => const ScheduledReportsPage(),
        ),
        // Notification routes
        GoRoute(
          path: notifications,
          name: 'notifications',
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: notificationSettings,
          name: 'notificationSettings',
          builder: (context, state) => const NotificationSettingsPage(),
        ),
        // Data Management routes
        GoRoute(
          path: dataExport,
          name: 'dataExport',
          builder: (context, state) => const DataExportPage(),
        ),
        GoRoute(
          path: analyticsCharts,
          name: 'analyticsCharts',
          builder: (context, state) => const AnalyticsChartsPage(),
        ),
        GoRoute(
          path: backupRestore,
          name: 'backupRestore',
          builder: (context, state) => const BackupRestorePage(),
        ),
        GoRoute(
          path: auditLogs,
          name: 'auditLogs',
          builder: (context, state) => const AuditLogsPage(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.uri.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(home),
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}