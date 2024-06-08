import 'package:risky_coin/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.id,
    required super.name,
    required super.description,
    required super.workshop,
    required super.price,
    required super.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      workshop: json['workshop'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'description': super.description,
      'workshop': super.workshop,
      'price': super.price,
      'quantity': super.quantity,
    };
  }
}