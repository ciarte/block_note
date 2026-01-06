import 'package:block_note/features/auth/data/datasource/user_datasource.dart';
import 'package:block_note/features/auth/data/model/user_model.dart';
import 'package:block_note/features/auth/domain/entity/user_entity.dart';
import 'package:block_note/features/auth/domain/repository/user_repository.dart';


class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource = UserDatasource();

  UserRepositoryImpl();

  @override
  Future<void> createUserData(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    await datasource.createUserData(userModel);
  }
}