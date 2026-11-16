import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class MockProductRepository implements ProductRepository {
  final List<Product> _products = [
    Product(
      id: 1,
      categoryId: 1,
      name: 'Agua mineral',
      description: '500 ml',
      price: 1200,
      isAvailable: true,
    ),
    Product(
      id: 2,
      categoryId: 1,
      name: 'Jugo de naranja',
      description: '200 ml',
      price: 1500,
      isAvailable: true,
    ),
    Product(
      id: 3,
      categoryId: 2,
      name: 'Alfajor de chocolate',
      description: '1 unidad',
      price: 1000,
      isAvailable: true,
    ),
    Product(
      id: 4,
      categoryId: 2,
      name: 'Papas fritas',
      description: 'Bolsa de 40 g',
      price: 1300,
      isAvailable: false,
    ), // Simula agotado
    Product(
      id: 5,
      categoryId: 3,
      name: 'Sándwich de milanesa',
      description: '1 unidad',
      price: 3500,
      isAvailable: true,
    ),
    Product(
      id: 6,
      categoryId: 3,
      name: 'Tarta de verdura',
      description: '1 porción',
      price: 3200,
      isAvailable: true,
    ),
  ];

  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simula red
    return _products;
  }

  @override
  Future<void> toggleAvailability(int productId, bool isAvailable) async {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _products[index] = Product(
        id: _products[index].id,
        categoryId: _products[index].categoryId,
        name: _products[index].name,
        description: _products[index].description,
        price: _products[index].price,
        isAvailable: isAvailable,
      );
    }
  }
}
