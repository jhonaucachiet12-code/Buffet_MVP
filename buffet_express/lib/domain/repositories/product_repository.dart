import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<void> toggleAvailability(int productId, bool isAvailable);
}
