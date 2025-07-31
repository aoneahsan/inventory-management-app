import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:inventory_management_plugin/inventory_management_plugin.dart';
import 'package:inventory_management_plugin/src/domain/repositories/product_repository.dart';
import 'package:inventory_management_plugin/src/services/sync/sync_service.dart';

import 'product_service_test.mocks.dart';

@GenerateMocks([ProductRepository, SyncService])
void main() {
  late ProductService productService;
  late MockProductRepository mockProductRepository;
  late MockSyncService mockSyncService;

  setUp(() {
    mockProductRepository = MockProductRepository();
    mockSyncService = MockSyncService();
    productService = ProductService(
      productRepository: mockProductRepository,
      syncService: mockSyncService,
    );
  });

  group('ProductService', () {
    group('createProduct', () {
      test('should create a product successfully', () async {
        // Arrange
        final product = Product(
          id: '1',
          name: 'Test Product',
          sku: 'SKU001',
          sellingPrice: 99.99,
          trackStock: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        when(mockProductRepository.create(any))
            .thenAnswer((_) async => product);
        when(mockSyncService.queueSync('products', product.id))
            .thenAnswer((_) async => {});

        // Act
        final result = await productService.createProduct(product);

        // Assert
        expect(result, equals(product));
        verify(mockProductRepository.create(product)).called(1);
        verify(mockSyncService.queueSync('products', product.id)).called(1);
      });

      test('should throw exception when product creation fails', () async {
        // Arrange
        final product = Product(
          id: '1',
          name: 'Test Product',
          sku: 'SKU001',
          sellingPrice: 99.99,
          trackStock: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        when(mockProductRepository.create(any))
            .thenThrow(Exception('Database error'));

        // Act & Assert
        expect(
          () => productService.createProduct(product),
          throwsException,
        );
        verifyNever(mockSyncService.queueSync(any, any));
      });
    });

    group('updateProduct', () {
      test('should update a product successfully', () async {
        // Arrange
        final product = Product(
          id: '1',
          name: 'Updated Product',
          sku: 'SKU001',
          sellingPrice: 149.99,
          trackStock: true,
          createdAt: DateTime.now().subtract(Duration(days: 1)),
          updatedAt: DateTime.now(),
        );

        when(mockProductRepository.update(any))
            .thenAnswer((_) async => product);
        when(mockSyncService.queueSync('products', product.id))
            .thenAnswer((_) async => {});

        // Act
        final result = await productService.updateProduct(product);

        // Assert
        expect(result, equals(product));
        verify(mockProductRepository.update(product)).called(1);
        verify(mockSyncService.queueSync('products', product.id)).called(1);
      });
    });

    group('getProducts', () {
      test('should return list of products', () async {
        // Arrange
        final products = [
          Product(
            id: '1',
            name: 'Product 1',
            sku: 'SKU001',
            sellingPrice: 99.99,
            trackStock: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          Product(
            id: '2',
            name: 'Product 2',
            sku: 'SKU002',
            sellingPrice: 149.99,
            trackStock: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

        when(mockProductRepository.getAll())
            .thenAnswer((_) async => products);

        // Act
        final result = await productService.getProducts();

        // Assert
        expect(result, equals(products));
        expect(result.length, equals(2));
        verify(mockProductRepository.getAll()).called(1);
      });
    });

    group('searchProducts', () {
      test('should return filtered products based on search query', () async {
        // Arrange
        final searchQuery = 'test';
        final products = [
          Product(
            id: '1',
            name: 'Test Product',
            sku: 'SKU001',
            sellingPrice: 99.99,
            trackStock: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

        when(mockProductRepository.searchProducts(searchQuery))
            .thenAnswer((_) async => products);

        // Act
        final result = await productService.searchProducts(searchQuery);

        // Assert
        expect(result, equals(products));
        expect(result.length, equals(1));
        expect(result.first.name.toLowerCase(), contains(searchQuery));
        verify(mockProductRepository.searchProducts(searchQuery)).called(1);
      });
    });

    group('deleteProduct', () {
      test('should delete a product successfully', () async {
        // Arrange
        const productId = '1';

        when(mockProductRepository.delete(productId))
            .thenAnswer((_) async => {});
        when(mockSyncService.queueSync('products', productId))
            .thenAnswer((_) async => {});

        // Act
        await productService.deleteProduct(productId);

        // Assert
        verify(mockProductRepository.delete(productId)).called(1);
        verify(mockSyncService.queueSync('products', productId)).called(1);
      });
    });

    group('getProductsByCategory', () {
      test('should return products for a specific category', () async {
        // Arrange
        const categoryId = 'cat1';
        final products = [
          Product(
            id: '1',
            name: 'Product 1',
            categoryId: categoryId,
            sku: 'SKU001',
            sellingPrice: 99.99,
            trackStock: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

        when(mockProductRepository.getByCategory(categoryId))
            .thenAnswer((_) async => products);

        // Act
        final result = await productService.getProductsByCategory(categoryId);

        // Assert
        expect(result, equals(products));
        expect(result.every((p) => p.categoryId == categoryId), isTrue);
        verify(mockProductRepository.getByCategory(categoryId)).called(1);
      });
    });

    group('getLowStockProducts', () {
      test('should return products with low stock', () async {
        // Arrange
        final products = [
          Product(
            id: '1',
            name: 'Low Stock Product',
            sku: 'SKU001',
            sellingPrice: 99.99,
            trackStock: true,
            reorderLevel: 10,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

        when(mockProductRepository.getLowStockProducts())
            .thenAnswer((_) async => products);

        // Act
        final result = await productService.getLowStockProducts();

        // Assert
        expect(result, equals(products));
        verify(mockProductRepository.getLowStockProducts()).called(1);
      });
    });

    group('getProductWithStock', () {
      test('should return product with current stock level', () async {
        // Arrange
        const productId = '1';
        final product = Product(
          id: productId,
          name: 'Product with Stock',
          sku: 'SKU001',
          sellingPrice: 99.99,
          trackStock: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        const currentStock = 25.0;

        when(mockProductRepository.getById(productId))
            .thenAnswer((_) async => product);
        when(mockProductRepository.getCurrentStock(productId))
            .thenAnswer((_) async => currentStock);

        // Act
        final result = await productService.getProductWithStock(productId);

        // Assert
        expect(result?.$1, equals(product));
        expect(result?.$2, equals(currentStock));
        verify(mockProductRepository.getById(productId)).called(1);
        verify(mockProductRepository.getCurrentStock(productId)).called(1);
      });

      test('should return null when product not found', () async {
        // Arrange
        const productId = 'non-existent';

        when(mockProductRepository.getById(productId))
            .thenAnswer((_) async => null);

        // Act
        final result = await productService.getProductWithStock(productId);

        // Assert
        expect(result, isNull);
        verify(mockProductRepository.getById(productId)).called(1);
        verifyNever(mockProductRepository.getCurrentStock(any));
      });
    });
  });
}