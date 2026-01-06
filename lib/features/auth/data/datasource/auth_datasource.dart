import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signup(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user?.sendEmailVerification();

    return credential;
  }

  bool isEmailVerified() {
    return _firebaseAuth.currentUser?.emailVerified ?? false;
  }

  Future<void> resetPassword(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> getUserId() async {
    return _firebaseAuth.currentUser?.uid;
  }
}
