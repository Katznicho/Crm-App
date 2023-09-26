import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/auth_controller.dart';
import 'auth/signin_blocs.dart';
import 'menu/menu_bloc.dart';

class AppProviders {
  static get allBlocProviders => [
        BlocProvider<AuthBloc>(
            create: (BuildContext context) =>
                AuthBloc(authController: AuthController())),
        BlocProvider<MenuBloc>(create: (BuildContext context) => MenuBloc()),
      ];
}
