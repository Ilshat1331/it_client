import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_client/app/domain/error_entity/error_entity.dart';
import 'package:it_client/app/ui/app_loader.dart';
import 'package:it_client/app/ui/components/app_snack_bar.dart';
import 'package:it_client/features/auth/domain/auth_state/auth_cubit.dart';
import 'package:it_client/features/auth/domain/entities/user_entity/user_entity.dart';
import 'package:it_client/features/auth/ui/update_password_screen.dart';
import 'package:it_client/features/auth/ui/update_profile_screen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authorized: (userEntity) {
              if (userEntity.userState?.hasData == true) {
                AppSnackBar.showSnackBarWithMessage(
                    context, userEntity.userState?.data);
              }
              if (userEntity.userState?.hasError == true) {
                AppSnackBar.showSnackBarWithError(context,
                    ErrorEntity.fromException(userEntity.userState?.error));
              }
            },
          );
        },
        builder: (context, state) {
          final UserEntity? user = state.whenOrNull(
            authorized: (userEntity) => userEntity,
          );
          if (user?.userState?.connectionState == ConnectionState.waiting) {
            return const AppLoager();
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      child: Text("?"),
                      // child: Text(user?.username.split("").first ?? "?"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Text(user?.username ?? ""),
                          Text(user?.email ?? ""),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdatePasswordScreen(),
                          ),
                        );
                      },
                      child: const Text("Refresh password"),
                    ),
                    const SizedBox(width: 16.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdateProfileScreen(),
                          ),
                        );
                      },
                      child: const Text("Update profile"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
