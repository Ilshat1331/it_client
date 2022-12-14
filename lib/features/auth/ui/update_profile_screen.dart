import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_client/app/ui/components/app_text_field.dart';
import 'package:it_client/features/auth/domain/auth_state/auth_cubit.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final emailController = TextEditingController();

  final usernameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    emailController.text = "";
    usernameController.text = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update profile screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              state.whenOrNull(
                authorized: (userEntity) => userEntity,
              );

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextField(controller: emailController, labelText: "Email"),
                  const SizedBox(height: 8),
                  AppTextField(
                      controller: usernameController, labelText: "Username"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().updateProfile(
                                username: usernameController.text,
                                email: emailController.text,
                              );
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Cancel"),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
