import 'package:flutter/material.dart';
import 'package:it_client/app/ui/app_loader.dart';
import 'package:it_client/features/auth/ui/components/auth_builder.dart';
import 'package:it_client/features/auth/ui/login_screen.dart';
import 'package:it_client/features/main/ui/main_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
      isNotAuthorized: (context) => LoginScreen(),
      isWaiting: (context) => const AppLoager(),
      isAuthorized: (context, value, child) => MainScreen(userEntity: value),
    );
  }
}
