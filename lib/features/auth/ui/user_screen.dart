import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_client/features/auth/domain/auth_state/auth_cubit.dart';
import 'package:it_client/features/auth/domain/entities/user_entity/user_entity.dart';

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
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final UserEntity? user = state.whenOrNull(
            authorized: (userEntity) => userEntity,
          );
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Text(user?.username.split("").first ?? "?"),
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
                      onPressed: () {},
                      child: const Text("Refresh password"),
                    ),
                    const SizedBox(width: 16.0),
                    TextButton(
                      onPressed: () {},
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
