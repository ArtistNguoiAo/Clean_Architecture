import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:risky_coin/domain/entity/user_entity.dart';
import 'package:risky_coin/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  @override
  Future<UserEntity> createUser(UserEntity user) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> getUser({String? id}) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  
}