part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginEventInit extends LoginEvent {}

class LoginEventLogin extends LoginEvent {
  final String email;
  final String password;

  LoginEventLogin({required this.email, required this.password});
}