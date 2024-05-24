import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:risky_coin/domain/use_case/register_with_email_password_use_case.dart';
import 'package:risky_coin/presentation/di/config_di.dart';
import 'package:risky_coin/presentation/utils/text_utils.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final RegisterWithEmailAndPasswordUseCase _registerWithEmailAndPasswordUseCase = ConfigDi().injector.get();

  Future<void> init() async {
    try {
      emit(RegisterLoaded());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  Future<void> register({required String email, required String password, required String confirmPassword}) async {
    emit(RegisterLoading());
    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      emit(RegisterError(TextUtils.emptyError));
    }
    else if(password != confirmPassword) {
      emit(RegisterError(TextUtils.confirmPasswordError));
    }
    else {
      try {
        await _registerWithEmailAndPasswordUseCase(
          email: email,
          password: password,
        );
        emit(RegisterRegisterSuccess());
      }
      catch(e) {
        if(e is FirebaseAuthException) {
          emit(RegisterError(e.message.toString()));
        }
        else {
          emit(RegisterError(e.toString()));
        }
      }
    }
  }
}
