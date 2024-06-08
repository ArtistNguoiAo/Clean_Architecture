import 'package:risky_coin/data/data_source/database_product.dart';
import 'package:risky_coin/data/model/product_model.dart';
import 'package:risky_coin/domain/entity/product_entity.dart';
import 'package:risky_coin/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DatabaseProduct databaseProduct = DatabaseProduct.db;

  @override
  Future<void> createProduct(ProductEntity product) async {
    await databaseProduct.insert(
        ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          workshop: product.workshop,
          price: product.price,
          quantity: product.quantity,
        )
    );
  }

  @override
  Future<List<ProductEntity>> getAllProduct() {
    return databaseProduct.products();
  }

  @override
  Future<ProductEntity> getProduct(int id) {
    return databaseProduct.getProduct(id);
  }

  @override
  Future<void> deleteProduct(int id) {
    return databaseProduct.delete(id);
  }

  @override
  Future<void> updateProduct(ProductEntity product) {
    return databaseProduct.update(
        ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          workshop: product.workshop,
          price: product.price,
          quantity: product.quantity,
        )
    );
  }
}