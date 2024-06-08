import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:risky_coin/domain/entity/user_entity.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> init() async {
    try {
      emit(ProfileLoaded());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
