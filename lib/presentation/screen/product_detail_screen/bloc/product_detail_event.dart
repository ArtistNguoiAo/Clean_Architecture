part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailEvent {}

final class ProductDetailInitEvent extends ProductDetailEvent{
  final int id;

  ProductDetailInitEvent({required this.id});
}

final class ProductDetailDeleteEvent extends ProductDetailEvent{
  final int id;

  ProductDetailDeleteEvent({required this.id});
}

final class ProductDetailUpdateEvent extends ProductDetailEvent{
  final ProductEntity productEntity;

  ProductDetailUpdateEvent({required this.productEntity});
}