import 'package:block_note/features/auth/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<void> createUserData(UserEntity user);
}