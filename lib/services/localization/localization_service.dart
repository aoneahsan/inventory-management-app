import 'dart:ui';
import '../../core/errors/exceptions.dart';

class LocalizationService {
  static final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'app_name': 'Inventory Management',
      'login': 'Login',
      'logout': 'Logout',
      'email': 'Email',
      'password': 'Password',
      'products': 'Products',
      'categories': 'Categories',
      'analytics': 'Analytics',
      'profile': 'Profile',
      'dashboard': 'Dashboard',
      'inventory': 'Inventory',
      'organization': 'Organization',
      'settings': 'Settings',
      'users': 'Users',
      'roles': 'Roles',
      'permissions': 'Permissions',
      'reports': 'Reports',
      'low_stock': 'Low Stock',
      'out_of_stock': 'Out of Stock',
      'add_product': 'Add Product',
      'edit_product': 'Edit Product',
      'delete_product': 'Delete Product',
      'save': 'Save',
      'cancel': 'Cancel',
      'create': 'Create',
      'update': 'Update',
      'delete': 'Delete',
      'search': 'Search',
      'filter': 'Filter',
      'total': 'Total',
      'value': 'Value',
      'quantity': 'Quantity',
      'price': 'Price',
      'cost': 'Cost',
      'revenue': 'Revenue',
      'profit': 'Profit',
      'error': 'Error',
      'success': 'Success',
      'warning': 'Warning',
      'info': 'Information',
      'loading': 'Loading...',
      'no_data': 'No data available',
      'refresh': 'Refresh',
      'export': 'Export',
      'import': 'Import',
      'backup': 'Backup',
      'restore': 'Restore',
      'skip': 'Skip',
      'previous': 'Previous',
      'next': 'Next',
      'get_started': 'Get Started',
    },
    'es': {
      'app_name': 'Gestión de Inventario',
      'login': 'Iniciar Sesión',
      'logout': 'Cerrar Sesión',
      'email': 'Correo Electrónico',
      'password': 'Contraseña',
      'products': 'Productos',
      'categories': 'Categorías',
      'analytics': 'Analítica',
      'profile': 'Perfil',
      'dashboard': 'Panel de Control',
      'inventory': 'Inventario',
      'organization': 'Organización',
      'settings': 'Configuración',
      'users': 'Usuarios',
      'roles': 'Roles',
      'permissions': 'Permisos',
      'reports': 'Reportes',
      'low_stock': 'Stock Bajo',
      'out_of_stock': 'Sin Stock',
      'add_product': 'Agregar Producto',
      'edit_product': 'Editar Producto',
      'delete_product': 'Eliminar Producto',
      'save': 'Guardar',
      'cancel': 'Cancelar',
      'create': 'Crear',
      'update': 'Actualizar',
      'delete': 'Eliminar',
      'search': 'Buscar',
      'filter': 'Filtrar',
      'total': 'Total',
      'value': 'Valor',
      'quantity': 'Cantidad',
      'price': 'Precio',
      'cost': 'Costo',
      'revenue': 'Ingresos',
      'profit': 'Ganancia',
      'error': 'Error',
      'success': 'Éxito',
      'warning': 'Advertencia',
      'info': 'Información',
      'loading': 'Cargando...',
      'no_data': 'No hay datos disponibles',
      'refresh': 'Actualizar',
      'export': 'Exportar',
      'import': 'Importar',
      'backup': 'Respaldo',
      'restore': 'Restaurar',
      'skip': 'Omitir',
      'previous': 'Anterior',
      'next': 'Siguiente',
      'get_started': 'Comenzar',
    },
    'fr': {
      'app_name': 'Gestion d\'Inventaire',
      'login': 'Connexion',
      'logout': 'Déconnexion',
      'email': 'Email',
      'password': 'Mot de Passe',
      'products': 'Produits',
      'categories': 'Catégories',
      'analytics': 'Analytique',
      'profile': 'Profil',
      'dashboard': 'Tableau de Bord',
      'inventory': 'Inventaire',
      'organization': 'Organisation',
      'settings': 'Paramètres',
      'users': 'Utilisateurs',
      'roles': 'Rôles',
      'permissions': 'Permissions',
      'reports': 'Rapports',
      'low_stock': 'Stock Faible',
      'out_of_stock': 'Rupture de Stock',
      'add_product': 'Ajouter Produit',
      'edit_product': 'Modifier Produit',
      'delete_product': 'Supprimer Produit',
      'save': 'Enregistrer',
      'cancel': 'Annuler',
      'create': 'Créer',
      'update': 'Mettre à Jour',
      'delete': 'Supprimer',
      'search': 'Rechercher',
      'filter': 'Filtrer',
      'total': 'Total',
      'value': 'Valeur',
      'quantity': 'Quantité',
      'price': 'Prix',
      'cost': 'Coût',
      'revenue': 'Revenus',
      'profit': 'Profit',
      'error': 'Erreur',
      'success': 'Succès',
      'warning': 'Avertissement',
      'info': 'Information',
      'loading': 'Chargement...',
      'no_data': 'Aucune donnée disponible',
      'refresh': 'Actualiser',
      'export': 'Exporter',
      'import': 'Importer',
      'backup': 'Sauvegarde',
      'restore': 'Restaurer',
      'skip': 'Ignorer',
      'previous': 'Précédent',
      'next': 'Suivant',
      'get_started': 'Commencer',
    },
  };

  static final List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('es', 'ES'),
    const Locale('fr', 'FR'),
  ];

  static Locale _currentLocale = const Locale('en', 'US');

  static Locale get currentLocale => _currentLocale;

  static String translate(String key) {
    final languageCode = _currentLocale.languageCode;
    final translations = _localizedStrings[languageCode];
    
    if (translations == null) {
      throw BusinessException(message: 'Unsupported language: $languageCode');
    }

    return translations[key] ?? key;
  }

  static Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) {
      throw BusinessException(message: 'Unsupported locale: ${locale.languageCode}');
    }

    _currentLocale = locale;
    // Here you would typically save to shared preferences
  }

  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      default:
        return languageCode.toUpperCase();
    }
  }

  static bool isRTL(String languageCode) {
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(languageCode);
  }
}

// Extension for easy access to translations
extension LocalizationExtension on String {
  String tr() {
    return LocalizationService.translate(this);
  }
}