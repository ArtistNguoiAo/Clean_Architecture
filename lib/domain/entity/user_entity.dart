class UserEntity {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? avatar;

  UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.avatar,
  });
}