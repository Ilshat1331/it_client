import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_client/app/ui/components/app_text_button.dart';
import 'package:it_client/app/ui/components/app_text_field.dart';
import 'package:it_client/features/auth/domain/auth_state/auth_cubit.dart';
import 'package:it_client/features/auth/ui/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Form(
        key: formKey,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(controller: controllerLogin, labelText: "Email"),
              const SizedBox(height: 16),
              AppTextField(
                  controller: controllerPassword,
                  labelText: "Password",
                  obscureText: true),
              const SizedBox(height: 16),
              AppTextButton(
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                    _onTapToSignIn(context.read<AuthCubit>());
                  }
                },
                text: "SIGN IN",
              ),
              const SizedBox(height: 16),
              AppTextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegistrationScreen(),
                  ));
                },
                text: "SIGN UP",
              ),
            ],
          ),
        )),
      ),
    );
  }

  void _onTapToSignIn(AuthCubit authCubit) => authCubit.signIn(
        email: controllerLogin.text,
        password: controllerPassword.text,
      );
}
