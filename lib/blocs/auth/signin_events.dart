abstract class AuthEvents {}

class SignInEvent extends AuthEvents {
  final String username;
  final String password;

  SignInEvent({required this.username, required this.password});
}

class SignOutEvent extends AuthEvents {}
