import 'package:risky_coin/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<ProductEntity> getProduct(int id);
  Future<List<ProductEntity>> getAllProduct();
  Future<void> createProduct(ProductEntity product);
  Future<void> updateProduct(ProductEntity product);
  Future<void> deleteProduct(int id);
}