import 'package:risky_coin/domain/entity/product_entity.dart';
import 'package:risky_coin/domain/repository/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository _productRepository;

  UpdateProductUseCase(this._productRepository);

  Future<void> updateProduct(ProductEntity product) async {
    await _productRepository.updateProduct(product);
  }
}