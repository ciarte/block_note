import 'package:block_note/features/auth/domain/entity/block_entity.dart';
import 'package:block_note/features/auth/domain/entity/block_entity_adapter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:block_note/features/auth/domain/usecase/auth_usecase.dart';
import 'package:block_note/features/auth/presentation/auth_view_model.dart';
import 'package:block_note/features/auth/data/repository/auth_repository_impl.dart';
import 'package:block_note/features/auth/data/repository/user_repository_impl.dart';
import 'package:block_note/features/auth/domain/usecase/user_usecase.dart';
import 'package:block_note/core/router/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(BlockEntityAdapter());
  await Hive.openBox<BlockEntity>('blocks');
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
            resetPasswordUsecase: ResetPasswordUsecase(repository),
          );
        })
      ],
      child: MaterialApp.router(
        title: 'Block Note',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: routes,
      ),
    );
  }
}
