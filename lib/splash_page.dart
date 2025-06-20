import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_bloc.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() async {
      final auth = context.read<AuthCubit>();
      final state = auth.state;

      if (state is! AuthAuthenticated && state is! AuthUnauthenticated) {
        await auth.checkAuthStatus();
      }

      final newState = auth.state;
      if (newState is AuthAuthenticated) {
        context.goNamed(wallet);
      } else {
        context.goNamed(login);
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
