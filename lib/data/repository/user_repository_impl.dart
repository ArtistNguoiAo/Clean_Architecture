import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:risky_coin/domain/entity/user_entity.dart';
import 'package:risky_coin/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  @override
  Future<UserEntity> getUser({String? id}) async {
    id ??= _firebaseAuth.currentUser?.uid;
    try {
      final data = await _firebaseDatabase.ref('users/$id').once();
      if (data.snapshot.value != null) {
        Map<Object?, dynamic> map = data.snapshot.value as Map<Object?, Object?>;
        return UserEntity(
          id: map['id'],
          name: map['name'],
          email: _firebaseAuth.currentUser?.email ?? map['email'],
          phone: map['phone'],
          address: map['address'],
          avatar: map['avatar'],
        );
      }
    }
    catch(e)  {
      print("TrungLQ: ${e.toString()}");
    }
    return UserEntity(
      id: _firebaseAuth.currentUser?.uid,
      name: _firebaseAuth.currentUser?.displayName ?? "",
      email: _firebaseAuth.currentUser?.email ?? "",
      phone: "",
      address: "",
      avatar: _firebaseAuth.currentUser?.photoURL,
    );
  }

  @override
  Future<UserEntity> createUser(UserEntity user) async {
    String? userId = _firebaseAuth.currentUser?.uid;
    await _firebaseDatabase.ref('users/$userId').set({
      "id": userId,
      "name": user.name,
      "email": user.email,
      "phone": user.phone,
      "address": user.address,
      "avatar": user.avatar,
    });
    return user;
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async {
    String? userId = _firebaseAuth.currentUser?.uid;
    await _firebaseDatabase.ref('users/$userId').update({
      "id": userId,
      "name": user.name,
      "email": user.email,
      "phone": user.phone,
      "address": user.address,
      "avatar": user.avatar,
    });
    return user;
  }
}