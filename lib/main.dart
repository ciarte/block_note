import 'package:block_note/features/auth/data/repository/user_repository_impl.dart';
import 'package:block_note/features/auth/domain/usecase/user_usecase.dart';
import 'package:block_note/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:block_note/features/auth/data/repository/auth_repository_impl.dart';
import 'package:block_note/features/auth/domain/usecase/auth_usecase.dart';
import 'package:block_note/features/auth/presentation/auth_view_model.dart';
import 'package:block_note/features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(create: (_) {
          final repository = AuthRepositoryImpl();
          final userRepository = UserRepositoryImpl();
          return AuthViewModel(
            createUserUsecase: CreateUserUsecase(userRepository),
            loginUsecase: LoginUsecase(repository),
            signupUsecase: SignupUsecase(repository),
            logOutUsecase: LogOutUsecase(repository),
          );
        })
      ],
      child: MaterialApp(
        title: 'Block Note',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(children: [LoginPage(), RegisterPage()]),
            ),
          ),
        ),
      ),
    );
  }
}
