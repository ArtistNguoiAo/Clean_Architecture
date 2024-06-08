import 'package:risky_coin/domain/entity/product_entity.dart';
import 'package:risky_coin/domain/repository/product_repository.dart';

class GetALlProductUseCase {
  final ProductRepository _productRepository;

  GetALlProductUseCase(this._productRepository);

  Future<List<ProductEntity>> call() {
    return _productRepository.getAllProduct();
  }
}