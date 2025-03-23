part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthInitialized extends AuthEvent {}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignUpRequested({required this.email, required this.password});
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignInRequested({required this.email, required this.password});
}

class AuthGoogleSignInRequested extends AuthEvent {}

class AuthAppleSignInRequested extends AuthEvent {}

class AuthEmailLinkRequested extends AuthEvent {
  final String email;

  AuthEmailLinkRequested({required this.email});
}

class AuthPasswordResetRequested extends AuthEvent {
  final String email;

  AuthPasswordResetRequested({required this.email});
}

class AuthSignOutRequested extends AuthEvent {}

class AuthDeleteAccountRequested extends AuthEvent {}

class CheckUserExistsRequested extends AuthEvent {
  final String email;
  CheckUserExistsRequested(this.email);
}
