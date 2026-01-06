import 'package:block_note/features/auth/presentation/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
    static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    static final _userController = TextEditingController();
    static final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
        final vm = context.watch<AuthViewModel>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextField(
            controller: _userController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),  
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),  
      
          ElevatedButton(
            onPressed: () => vm.signup(_userController.text, _passwordController.text),
            child: const Text('signUp')),
        ],
      ),
    );
  }
}