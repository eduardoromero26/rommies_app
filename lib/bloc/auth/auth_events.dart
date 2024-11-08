part of 'auth_bloc.dart';

class AuthEvent {
  const AuthEvent();
}

class LoginWithEmail extends AuthEvent {
  final String email;
  final String password;
  const LoginWithEmail(this.email, this.password);
}
