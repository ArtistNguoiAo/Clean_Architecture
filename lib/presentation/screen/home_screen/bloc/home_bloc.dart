import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:risky_coin/domain/entity/user_entity.dart';
import 'package:risky_coin/domain/use_case/create_user_profile_use_case.dart';
import 'package:risky_coin/domain/use_case/update_user_profile_use_case.dart';
import 'package:risky_coin/presentation/di/config_di.dart';

import '../../../../domain/use_case/get_user_profile_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEventInit>(_onInit);
    on<HomeEventSave>(_onSave);
    on<HomeEventCreate>(_onCreate);
  }

  final CreateUserProfileUseCase _createUserProfileUseCase = ConfigDi().injector.get();
  final UpdateUserProfileUseCase _updateUserProfileUseCase = ConfigDi().injector.get();
  final GetUserProfileUseCase _getUserProfileUseCase = ConfigDi().injector.get();

  FutureOr<void> _onInit(HomeEventInit event, Emitter<HomeState> emit) async {
    try {
      UserEntity userEntity = await _getUserProfileUseCase();
      emit(HomeStateLoaded(userEntity));
    } catch (e) {
      emit(HomeStateError(e.toString()));
    }
  }

  FutureOr<void> _onCreate(HomeEventCreate event, Emitter<HomeState> emit) async{
    try {
      emit(HomeStateLoading());
      await _createUserProfileUseCase(event.userEntity);
      UserEntity userEntity = await _getUserProfileUseCase();
      emit(HomeStateLoaded(userEntity));
    } catch (e) {
      emit(HomeStateError(e.toString()));
    }
  }

  FutureOr<void> _onSave(HomeEventSave event, Emitter<HomeState> emit) async {
    try {
      emit(HomeStateLoading());
      await _updateUserProfileUseCase(event.userEntity);
      UserEntity userEntity = await _getUserProfileUseCase();
      emit(HomeStateLoaded(userEntity));
    } catch (e) {
      emit(HomeStateError(e.toString()));
    }
  }
}
