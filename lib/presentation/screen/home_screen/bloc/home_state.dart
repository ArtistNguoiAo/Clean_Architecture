part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final UserEntity userEntity;

  HomeStateLoaded(this.userEntity);
}

class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);
}