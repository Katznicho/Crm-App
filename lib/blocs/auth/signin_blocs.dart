import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm_app/blocs/auth/signin_events.dart';
import 'package:crm_app/blocs/auth/signin_states.dart';

import '../../controllers/auth_controller.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthController authController;

  AuthBloc({required this.authController}) : super(SignInLoading()) {
    init();

    on<SignInEvent>(_signInEvent);
    on<SignOutEvent>(_signOutEvent);
  }

  init() async {
    String accessToken = await authController.getAccessToken();
    if (accessToken.isNotEmpty) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnAuthenticated());
      add(SignOutEvent());
    }
  }

  _signInEvent(SignInEvent event, Emitter<AuthStates> emit) async {
    emit(SignInLoading());
    Map<String, dynamic>? response =
        await authController.signIn(event.username, event.password);
    if (response != null) {
      emit(SignInSuccess());
    } else {
      emit(const SignInFailure(errorMessage: "Invalid Credentials, Try Again"));
    }
  }

  _signOutEvent(SignOutEvent event, Emitter<AuthStates> emit) async {
    emit(SignInLoading());
    await authController.signOut();
    signOut();
    emit(AuthUnAuthenticated());
  }

  signOut() async {
    void response = await authController.signOut();
    emit(SignOutSuccess());
  }
}
