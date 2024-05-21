import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:risky_coin/domain/use_case/register_with_email_password_use_case.dart';
import 'package:risky_coin/presentation/di/config_di.dart';
import 'package:risky_coin/presentation/utils/text_utils.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEventInit>(_onInit);
    on<RegisterEventRegister>(_onRegister);
  }

  final RegisterWithEmailAndPasswordUseCase _registerWithEmailAndPasswordUseCase = ConfigDi().injector.get();

  FutureOr<void> _onInit(RegisterEventInit event, Emitter<RegisterState> emit) async {
    try {
      emit(RegisterStateLoaded());
    } catch (e) {
      emit(RegisterStateError(e.toString()));
    }
  }

  FutureOr<void> _onRegister(RegisterEventRegister event, Emitter<RegisterState> emit) async {
    emit(RegisterStateLoading());
    if(event.email.isEmpty || event.password.isEmpty || event.confirmPassword.isEmpty) {
      emit(RegisterStateError(TextUtils.emptyError));
    }
    else if(event.password != event.confirmPassword) {
      emit(RegisterStateError(TextUtils.confirmPasswordError));
    }
    else {
      try {
        await _registerWithEmailAndPasswordUseCase(
          email: event.email,
          password: event.password,
        );
        emit(RegisterStateRegisterSuccess());
      }
      catch(e) {
        if(e is FirebaseAuthException) {
          emit(RegisterStateError(e.message.toString()));
        }
        else {
          emit(RegisterStateError(e.toString()));
        }
      }
    }
  }
}
