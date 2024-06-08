import 'package:risky_coin/domain/repository/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository _productRepository;

  DeleteProductUseCase(this._productRepository);

  Future<void> call(int id) async {
    return _productRepository.deleteProduct(id);
  }
}