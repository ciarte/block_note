import 'package:block_note/features/auth/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    super.displayName,
  });

  factory UserModel.fromFirebase(UserCredential userCredential) {
    return UserModel(
      id: userCredential.user?.uid ?? '',
      email: userCredential.user?.email ?? '',
      displayName: userCredential.user?.displayName,
    );
  }

  factory UserModel.fromEntity(UserEntity userCredential) {
    return UserModel(
      id: userCredential.id,
      email: userCredential.email,
      displayName: userCredential.displayName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
    };
  }
}
