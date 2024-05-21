part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterEventInit extends RegisterEvent {}

class RegisterEventRegister extends RegisterEvent {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterEventRegister({required this.email, required this.password, required this.confirmPassword});
}