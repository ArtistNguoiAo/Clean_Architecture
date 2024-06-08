import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:risky_coin/domain/entity/product_entity.dart';
import 'package:risky_coin/domain/use_case/product_use_case/delete_product_use_case.dart';
import 'package:risky_coin/domain/use_case/product_use_case/get_product_use_case.dart';
import 'package:risky_coin/domain/use_case/product_use_case/update_product_use_case.dart';
import 'package:risky_coin/presentation/di/config_di.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<ProductDetailInitEvent>(_init);
    on<ProductDetailDeleteEvent>(_delete);
    on<ProductDetailUpdateEvent>(_update);
  }

  final GetProductUseCase _getProductUseCase = ConfigDi().injector.get();
  final DeleteProductUseCase _deleteProductUseCase = ConfigDi().injector.get();
  final UpdateProductUseCase _updateProductUseCase = ConfigDi().injector.get();

  Future<void> _init(ProductDetailInitEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    try {
      final product = await _getProductUseCase.call(event.id);
      emit(ProductDetailLoaded(productEntity: product));
    } catch (e) {
      emit(ProductDetailError(message: e.toString()));
    }
  }

  Future<void> _delete(ProductDetailDeleteEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    try {
      await _deleteProductUseCase.call(event.id);
      emit(ProductDetailDeleted());
    } catch (e) {
      emit(ProductDetailError(message: e.toString()));
    }
  }

  Future<void> _update(ProductDetailUpdateEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    try {
      await _updateProductUseCase.updateProduct(event.productEntity);
      emit(ProductDetailUpdated());
    } catch (e) {
      emit(ProductDetailError(message: e.toString()));
    }
  }
}
