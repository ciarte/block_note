import 'package:block_note/features/auth/domain/entity/user_entity.dart';
import 'package:block_note/features/auth/domain/usecase/auth_usecase.dart';
import 'package:block_note/features/auth/domain/usecase/user_usecase.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  final LogOutUsecase logOutUsecase;
  final CreateUserUsecase createUserUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;

  AuthViewModel(
      {required this.loginUsecase,
      required this.signupUsecase,
      required this.logOutUsecase,
      required this.createUserUsecase,
      required this.resetPasswordUsecase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserEntity? _user;
  UserEntity? get user => _user;

  String? successMessage;
  String? errorMessage;
  String? error;

  Future<void> login(String email, String pass) async {
    _setLoading(true);
    try {
      _user = await loginUsecase(email.trim(), pass);
      await createUserUsecase(_user!);
      successMessage = 'Wellcome back !';
      errorMessage = null;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Something went wrong, please try again.';
      successMessage = null;
    }
    _setLoading(false);
  }

  Future<void> signup(String email, String pass) async {
    _setLoading(true);
    try {
      _user = await signupUsecase(email.toUpperCase().trim(), pass);
      successMessage = 'Registration successful, check your email inbox';
      errorMessage = null;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Something went wrong, please try again.';
      successMessage = null;
    }
    _setLoading(false);
  }

  Future<void> resetPassword(String email) async {
    _setLoading(true);
    try {
      await resetPasswordUsecase(email);
      successMessage = 'Check your email to reset your password.';
      successMessage = null;
    } catch (e) {
      errorMessage = 'Something went wrong, please try again.';
      successMessage = null;
    }
    _setLoading(false);
    notifyListeners();
  }

  Future<void> logout() async {
    _setLoading(true);
    try {
      await logOutUsecase();
      _user = null;
    } catch (e) {
      errorMessage = 'Something went wrong, please try again.';
      successMessage = null;
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
