import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:risky_coin/domain/entity/product_entity.dart';
import 'package:risky_coin/domain/use_case/product_use_case/create_product_use_case.dart';
import 'package:risky_coin/presentation/di/config_di.dart';

part 'product_create_event.dart';
part 'product_create_state.dart';

class ProductCreateBloc extends Bloc<ProductCreateEvent, ProductCreateState> {
  ProductCreateBloc() : super(ProductCreateInitial()) {
    on<ProductCreateInitEvent>(_init);
    on<ProductCreateAddEvent>(_add);
  }

  CreateProductUseCase _createProductUseCase = ConfigDi().injector.get();

  Future<void> _init(ProductCreateInitEvent event, Emitter<ProductCreateState> emit) async {
    emit(ProductCreateLoading());
    try {
      emit(ProductCreateLoaded());
    } catch (e) {
      emit(ProductCreateError(e.toString()));
    }
  }

  Future<void> _add(ProductCreateAddEvent event, Emitter<ProductCreateState> emit) async {
    emit(ProductCreateLoading());
    try {
      if(event.name.isEmpty || event.description.isEmpty || event.workshop.isEmpty || event.price.isEmpty || event.quantity.isEmpty) {
        emit(ProductCreateError("Vui lòng điền đủ thông tin"));
        emit(ProductCreateLoaded());
        return;
      }
      else {
        final product = ProductEntity(
          name: event.name,
          description: event.description,
          workshop: event.workshop,
          price: event.price,
          quantity: event.quantity,
        );
        await _createProductUseCase(product);
        emit(ProductCreateSuccess());
      }
    } catch (e) {
      emit(ProductCreateError(e.toString()));
    }
  }
}
