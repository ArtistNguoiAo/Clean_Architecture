part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeEventInit extends HomeEvent {}

class HomeEventCreate extends HomeEvent {
  final UserEntity userEntity;

  HomeEventCreate({
    required this.userEntity,
  });
}

class HomeEventSave extends HomeEvent {
  final UserEntity userEntity;

  HomeEventSave({
    required this.userEntity,
  });
}