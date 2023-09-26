class AuthStates {
  const AuthStates();
}

class SignInLoading extends AuthStates {}

class SignInSuccess extends AuthStates {}

class SignOutSuccess extends AuthStates {}

class SignInFailure extends AuthStates {
  final String errorMessage;

  const SignInFailure({required this.errorMessage});
}

class AuthAuthenticated extends AuthStates {}

class AuthUnAuthenticated extends AuthStates {}
