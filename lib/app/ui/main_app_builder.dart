import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_client/app/di/init_di.dart';
import 'package:it_client/app/domain/app_builder.dart';
import 'package:it_client/app/ui/root_screen.dart';

import '../../features/auth/domain/auth_state/auth_cubit.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp() {
    return const _GlobaProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RootScreen(),
      ),
    );
  }
}

class _GlobaProviders extends StatelessWidget {
  const _GlobaProviders({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator.get<AuthCubit>(),
        ),
      ],
      child: child,
    );
  }
}
