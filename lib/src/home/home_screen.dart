import 'package:flutter/material.dart';
import 'package:gidcaf/widgets/auth_guard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthGuard(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Главная страница'),
        ),
        body: const Center(
          child: Text('Добро пожаловать!'),
        ),
      ),
    );
  }
}