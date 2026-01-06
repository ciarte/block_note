import 'package:block_note/features/auth/domain/entity/user_entity.dart';
import 'package:block_note/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<UserEntity> call(String email, String pass) async {
    return await repository.login(email, pass);
  }
}

class SignupUsecase {
  final AuthRepository repository;

  SignupUsecase(this.repository);

  Future<UserEntity> call(String email, String pass) async {
    return await repository.signup(email, pass);
  }
}

class LogOutUsecase {
  final AuthRepository repository;

  LogOutUsecase(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}
