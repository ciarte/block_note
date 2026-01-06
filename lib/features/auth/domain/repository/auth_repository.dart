import 'package:block_note/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> signup(String email, String password);
  Future<void> logout();
  Future<void> resetPassword(String email);
  Future<String?> getUserId();
}