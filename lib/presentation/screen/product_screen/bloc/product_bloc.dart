import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:risky_coin/domain/entity/product_entity.dart';
import 'package:risky_coin/domain/use_case/product_use_case/get_all_product_use_case.dart';
import 'package:risky_coin/presentation/di/config_di.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductInitEvent>(_init);
  }

  final GetALlProductUseCase _getAllProductUseCase = ConfigDi().injector.get();

  Future<void> _init(ProductInitEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await _getAllProductUseCase.call();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
