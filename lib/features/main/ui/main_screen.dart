import 'package:flutter/material.dart';
import 'package:it_client/features/auth/domain/entities/user_entity/user_entity.dart';
import 'package:it_client/features/auth/ui/user_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserScreen(),
              ),
            ),
            icon: const Icon(Icons.account_box),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Text("Text"),
            )
          ],
        ),
      ),
    );
  }
}
