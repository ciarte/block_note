

import 'package:block_note/features/auth/data/datasource/auth_datasource.dart';
import 'package:block_note/features/auth/data/model/user_model.dart';
import 'package:block_note/features/auth/domain/entity/user_entity.dart';
import 'package:block_note/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource = AuthDatasource();
  @override
  Future<String?> getUserId() async {
    final result =  await datasource.getUserId();
    return result;
  }

  @override
  Future<UserEntity> login(String email, String password) async{
      final result = await datasource.login(email, password);
      return UserModel.fromFirebase(result);
  }

  @override
  Future<void> logout() async{
    await datasource.logout();
  }

  @override
  Future<UserEntity> signup(String email, String password) async{
    final result = await datasource.signup(email, password);
    return UserModel.fromFirebase(result);
  }
}