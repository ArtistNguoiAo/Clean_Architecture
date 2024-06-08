part of 'product_create_bloc.dart';

@immutable
sealed class ProductCreateEvent {}

final class ProductCreateInitEvent extends ProductCreateEvent {}

final class ProductCreateAddEvent extends ProductCreateEvent {
  final String name;
  final String description;
  final String workshop;
  final String price;
  final String quantity;

  ProductCreateAddEvent({required this.name, required this.description, required this.workshop, required this.price, required this.quantity});
}