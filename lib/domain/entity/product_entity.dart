class ProductEntity {
  final int? id;
  final String name;
  final String description;
  final String workshop;
  final String price;
  final String quantity;

  ProductEntity({
    this.id,
    required this.name,
    required this.description,
    required this.workshop,
    required this.price,
    required this.quantity,
  });
}