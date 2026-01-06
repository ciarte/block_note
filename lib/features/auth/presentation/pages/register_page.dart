import 'package:block_note/features/auth/presentation/auth_view_model.dart';
import 'package:block_note/features/auth/presentation/pages/login_page.dart';
import 'package:block_note/utils/inputs_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
static const String name = 'RegisterPage';

  const RegisterPage({super.key});
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final _userController = TextEditingController();
  static final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 10,
          children: [
            Container(
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/notes_logo.png')))),
            Text('Create Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            textEmailInput('Email', _userController),
            textPassInput(
                'Password', 'Please enter your password', _passwordController),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    vm.signup(_userController.text, _passwordController.text);
                    if (!context.mounted) return;
                    if (vm.successMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(vm.successMessage!),
                          backgroundColor: Colors.green,
                        ),
                      );
                      context.goNamed(LoginPage.name);
                    }

                    if (vm.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(vm.errorMessage!),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    )));
  }
}
