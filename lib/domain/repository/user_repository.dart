import 'package:risky_coin/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser({String? id});
  Future<UserEntity> createUser(UserEntity user);
  Future<UserEntity> updateUser(UserEntity user);
}