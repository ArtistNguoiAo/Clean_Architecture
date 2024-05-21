import 'package:risky_coin/domain/repository/auth_repository.dart';

class LoginWithEmailPasswordUseCase {
  final AuthRepository _authRepository;

  LoginWithEmailPasswordUseCase(this._authRepository);

  Future<void> call({
    required String email,
    required String password,
  }) async {
    return await _authRepository.login(
      email,
      password,
    );
  }
}