import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:risky_coin/domain/use_case/login_with_email_password_use_case.dart';
import 'package:risky_coin/presentation/di/config_di.dart';
import 'package:risky_coin/presentation/utils/text_utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEventInit>(_onInit);
    on<LoginEventLogin>(_onLogin);
  }

  final LoginWithEmailPasswordUseCase _loginWithEmailPasswordUseCase = ConfigDi().injector.get();

  FutureOr<void> _onInit(LoginEventInit event, Emitter<LoginState> emit) async {
    try {
      emit(LoginStateLoaded());
    } catch (e) {
      emit(LoginStateError(e.toString()));
    }
  }

  FutureOr<void> _onLogin(LoginEventLogin event, Emitter<LoginState> emit) async {
    emit(LoginStateLoading());
    if(event.email.isEmpty || event.password.isEmpty) {
      emit(LoginStateError(TextUtils.emptyError));
    }
    else {
      try {
        await _loginWithEmailPasswordUseCase(
          email: event.email,
          password: event.password,
        );
        emit(LoginStateLoginSuccess());
      }
      catch(e) {
        if(e is FirebaseAuthException) {
          emit(LoginStateError(e.message.toString()));
        }
        else {
          emit(LoginStateError(e.toString()));
        }
      }
    }
  }
}
