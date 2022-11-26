import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_client/app/ui/components/app_text_field.dart';
import 'package:it_client/features/auth/domain/auth_state/auth_cubit.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final newPasswordController = TextEditingController();

  final oldPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    newPasswordController.text = "";
    oldPasswordController.text = "";
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
                  AppTextField(
                    controller: oldPasswordController,
                    labelText: "Old Password",
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: newPasswordController,
                    labelText: "New Password",
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().updatePassword(
                                oldPassword: oldPasswordController.text,
                                newPassword: newPasswordController.text,
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
