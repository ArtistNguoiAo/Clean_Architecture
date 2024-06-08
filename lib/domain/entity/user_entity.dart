class UserEntity {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final int position;

  UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.position,
  });
}