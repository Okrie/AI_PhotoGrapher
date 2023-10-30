import 'package:flutter/material.dart';
import 'package:photographer_ai/View/login/widget/loginform.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: const LoginForm()
    );
  }
}