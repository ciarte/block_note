

import 'package:block_note/features/auth/domain/entity/user_entity.dart';
import 'package:block_note/features/auth/domain/repository/user_repository.dart';

class CreateUserUsecase {
  final UserRepository repository;

  CreateUserUsecase(this.repository);

  Future<void> call(UserEntity user) {
    return repository.createUserData(user);
  }
}
