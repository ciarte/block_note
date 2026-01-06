import 'package:block_note/features/auth/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserDatasource();

  Future<void> createUserData(  UserModel user) async {
    await firestore.collection('users').doc(user.id).set({
      'createdAt': FieldValue.serverTimestamp(),
      'email': user.email,
      'displayName': user.displayName,
    });
  }
}