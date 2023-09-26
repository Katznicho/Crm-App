import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm_app/blocs/auth/signin_blocs.dart';
import 'package:crm_app/blocs/auth/signin_states.dart';
import 'package:crm_app/utils/constants/app_routes.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthStates>(
      listener: (context, state) {
        if (state is AuthUnAuthenticated) {
          Navigator.pushNamed(context, AppRoutes.SIGN_IN);
        }

        if (state is AuthAuthenticated) {
          Navigator.pushNamed(context, AppRoutes.HOME);
        }
      },
      //circluar progress indicator in the middle of the screen
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
