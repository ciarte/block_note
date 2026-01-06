import 'package:block_note/features/auth/domain/entity/user_entity.dart';
import 'package:block_note/features/auth/domain/usecase/auth_usecase.dart';
import 'package:block_note/features/auth/domain/usecase/user_usecase.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  final LogOutUsecase logOutUsecase;
  final CreateUserUsecase createUserUsecase;

  AuthViewModel(
      {required this.loginUsecase,
      required this.signupUsecase,
      required this.logOutUsecase,
      required this.createUserUsecase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserEntity? _user;
  UserEntity? get user => _user;

  String? error;

  Future<void> login(String email, String pass, String? displayName) async {
    _setLoading(true);
    try {
      _user = await loginUsecase(email.toUpperCase().trim(), pass);
      _user = _user!.copyWith(displayName: displayName ?? email);
      createUserUsecase(_user!);
    } catch (e) {
      error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> signup(String email, String pass) async {
    _setLoading(true);
    try {
      _user = await signupUsecase(email.toUpperCase().trim(), pass);
    } catch (e) {
      error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> logout() async {
    _setLoading(true);
    try {
      await logOutUsecase();
      _user = null;
    } catch (e) {
      error = e.toString();
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
