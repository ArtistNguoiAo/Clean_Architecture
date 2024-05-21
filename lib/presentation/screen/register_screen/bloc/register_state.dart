part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterStateLoading extends RegisterState {}

class RegisterStateLoaded extends RegisterState {}

class RegisterStateRegisterSuccess extends RegisterState {}

class RegisterStateError extends RegisterState {
  final String message;

  RegisterStateError(this.message);
}