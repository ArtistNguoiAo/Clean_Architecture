import 'package:risky_coin/domain/entity/user_entity.dart';
import 'package:risky_coin/domain/repository/user_repository.dart';

class CreateUserProfileUseCase {
  final UserRepository _userRepository;

  CreateUserProfileUseCase(this._userRepository);

  Future<UserEntity> call(UserEntity userEntity) async {
    return await _userRepository.createUser(userEntity);
  }
}