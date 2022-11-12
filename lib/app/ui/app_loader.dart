import 'package:flutter/material.dart';

class AppLoager extends StatelessWidget {
  const AppLoager({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
