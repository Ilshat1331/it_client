import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_client/app/ui/components/app_text_button.dart';
import 'package:it_client/app/ui/components/app_text_field.dart';
import 'package:it_client/features/auth/domain/auth_state/auth_cubit.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final controllerUsername = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPasswordConfirm = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Screen"),
      ),
      body: Form(
        key: formKey,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(controller: controllerEmail, labelText: "Email"),
              const SizedBox(height: 16),
              AppTextField(
                  controller: controllerUsername, labelText: "Username"),
              const SizedBox(height: 16),
              AppTextField(
                  controller: controllerPassword,
                  labelText: "Password",
                  obscureText: true),
              const SizedBox(height: 16),
              AppTextField(
                  controller: controllerPasswordConfirm,
                  labelText: "Confirm password",
                  obscureText: true),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              AppTextButton(
                onPressed: () {
                  if (formKey.currentState?.validate() != true) return;
                  if (controllerPassword.text !=
                      controllerPasswordConfirm.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Passwords do not match")));
                  } else {
                    _onTapToSignUp(context.read<AuthCubit>());
                    Navigator.of(context).pop();
                  }
                },
                text: "SIGN UP",
              ),
            ],
          ),
        )),
      ),
    );
  }

  void _onTapToSignUp(AuthCubit authCubit) => authCubit.signUp(
        email: controllerEmail.text,
        username: controllerUsername.text,
        password: controllerPassword.text,
      );
}
