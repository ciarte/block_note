import 'package:block_note/features/auth/presentation/pages/block_page.dart';
import 'package:block_note/features/auth/presentation/pages/login_page.dart';
import 'package:block_note/features/auth/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/',
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
      builder: (context, state) => BlockPage(),
    ),
  ],
);