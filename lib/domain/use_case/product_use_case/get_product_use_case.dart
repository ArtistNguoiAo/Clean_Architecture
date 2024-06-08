import 'package:risky_coin/domain/entity/product_entity.dart';
import 'package:risky_coin/domain/repository/product_repository.dart';

class GetProductUseCase {
  final ProductRepository _productRepository;

  GetProductUseCase(this._productRepository);

  Future<ProductEntity> call(int id) {
    return _productRepository.getProduct(id);
  }
}