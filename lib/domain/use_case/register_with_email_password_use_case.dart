import 'package:risky_coin/domain/repository/auth_repository.dart';

class RegisterWithEmailAndPasswordUseCase {
  final AuthRepository _authRepository;

  RegisterWithEmailAndPasswordUseCase(this._authRepository);

  Future<void> call({
    required String email,
    required String password,
  }) async {
    return await _authRepository.register(
      email,
      password,
    );
  }
}