part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateLoaded extends LoginState {}

class LoginStateLoginSuccess extends LoginState {}

class LoginStateError extends LoginState {
  final String message;

  LoginStateError(this.message);
}