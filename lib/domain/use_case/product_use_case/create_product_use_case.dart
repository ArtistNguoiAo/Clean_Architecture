import 'package:risky_coin/domain/entity/product_entity.dart';
import 'package:risky_coin/domain/repository/product_repository.dart';

class CreateProductUseCase {
  final ProductRepository _productRepository;

  CreateProductUseCase(this._productRepository);

  Future<void> call(ProductEntity product) async {
    await _productRepository.createProduct(product);
  }
}