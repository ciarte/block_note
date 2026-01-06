import 'package:block_note/features/auth/presentation/auth_view_model.dart';
import 'package:block_note/features/auth/presentation/pages/block_page.dart';
import 'package:block_note/features/auth/presentation/pages/register_page.dart';
import 'package:block_note/utils/inputs_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const String name = 'LoginPage';

  LoginPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                spacing: 10,
                children: [
                  Container(
                      height: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image:
                                  AssetImage('assets/images/notes_logo.png')))),
                  textEmailInput('Email', _userController),
                  textInput('Username', 'Please enter your username',
                      _userNameController),
                  textPassInput('Password', 'Please enter your password',
                      _passwordController),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          vm.login(
                              _userController.text,
                              _passwordController.text,
                              _userNameController.text);
                        }
                        if (!context.mounted) return;
                        if (vm.successMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(vm.successMessage!),
                              backgroundColor: Colors.green,
                            ),
                          );
                          context.goNamed(BlockPage.name);
                        }

                        if (vm.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(vm.errorMessage!),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () =>
                              vm.resetPassword(_userController.text),
                          child: Text('forgot your password?')),
                      TextButton(
                          onPressed: () => context.goNamed(RegisterPage.name),
                          child: Text('create an account')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
