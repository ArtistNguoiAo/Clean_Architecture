part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailState {}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailLoading extends ProductDetailState {}

final class ProductDetailLoaded extends ProductDetailState {
  final ProductEntity productEntity;

  ProductDetailLoaded({required this.productEntity});
}

final class ProductDetailDeleted extends ProductDetailState {}

final class ProductDetailUpdated extends ProductDetailState {}

final class ProductDetailError extends ProductDetailState {
  final String message;

  ProductDetailError({required this.message});
}