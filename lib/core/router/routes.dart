import 'package:block_note/features/auth/data/repository/block_repository_impl.dart';
import 'package:block_note/features/auth/domain/entity/user_entity.dart';
import 'package:block_note/features/auth/domain/usecase/block_usecase.dart';
import 'package:block_note/features/auth/presentation/block_view_model.dart';
import 'package:block_note/features/auth/presentation/pages/block_page.dart';
import 'package:block_note/features/auth/presentation/pages/login_page.dart';
import 'package:block_note/features/auth/presentation/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final GoRouter routes = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final user = _auth.currentUser;
    final loggingIn = state.matchedLocation == '/';
    if (user == null) {
      return loggingIn ? null : '/';
    }
    if (loggingIn) {
      return '/block';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      name: LoginPage.name,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: RegisterPage.name,
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: '/block',
      name: BlockPage.name,
      builder: (context, state) {
        final firebaseUser = _auth.currentUser!;
        final user = UserEntity(
          id: firebaseUser.uid,
          email: firebaseUser.email!,
        );
        return ChangeNotifierProvider(
          create: (_) {
            final vm = BlockViewModel(
              user: user,
              blockUsecase: BlockUsecase(
                BlockRepositoryImpl(),
              ),
            );
            vm.start();
            return vm;
          },
          child: const BlockPage(),
        );
      },
    ),
  ],
);
