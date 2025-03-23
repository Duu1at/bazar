import 'dart:async';

import 'package:authentication_client/authentication_client.dart';

/// {@template authentication_exception}
/// Exceptions from the authentication client.
/// {@endtemplate}
abstract class AuthenticationException implements Exception {
  /// {@macro authentication_exception}
  const AuthenticationException(this.error);

  /// The error which was caught.
  final Object error;
}

/// {@template send_login_email_link_failure}
/// Thrown during the sending login email link process if a failure occurs.
/// {@endtemplate}
class SendLoginEmailLinkFailure extends AuthenticationException {
  /// {@macro send_login_email_link_failure}
  const SendLoginEmailLinkFailure(super.error);
}

/// {@template is_log_in_email_link_failure}
/// Thrown during the validation of the email link process if a failure occurs.
/// {@endtemplate}
class IsLogInWithEmailLinkFailure extends AuthenticationException {
  /// {@macro is_log_in_email_link_failure}
  const IsLogInWithEmailLinkFailure(super.error);
}

/// {@template log_in_with_email_link_failure}
/// Thrown during the sign in with email link process if a failure occurs.
/// {@endtemplate}
class LogInWithEmailLinkFailure extends AuthenticationException {
  /// {@macro log_in_with_email_link_failure}
  const LogInWithEmailLinkFailure(super.error);
}

/// {@template log_in_with_apple_failure}
/// Thrown during the sign in with apple process if a failure occurs.
/// {@endtemplate}
class LogInWithAppleFailure extends AuthenticationException {
  /// {@macro log_in_with_apple_failure}
  const LogInWithAppleFailure(super.error);
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// {@endtemplate}
class LogInWithGoogleFailure extends AuthenticationException {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure(super.error);
}

/// {@template log_out_failure}
/// Thrown during the logout process if a failure occurs.
/// {@endtemplate}
class LogOutFailure extends AuthenticationException {
  /// {@macro log_out_failure}
  const LogOutFailure(super.error);
}

/// {@template delete_account_failure}
/// Thrown during the delete account process if a failure occurs.
/// {@endtemplate}
class DeleteAccountFailure extends AuthenticationException {
  /// {@macro delete_account_failure}
  const DeleteAccountFailure(super.error);
}

class ResetPasswordFailure extends AuthenticationException {
  const ResetPasswordFailure(super.error);
}

class UpdateProfileFailure extends AuthenticationException {
  const UpdateProfileFailure(super.error);
}

class SignUpFailure extends AuthenticationException {
  const SignUpFailure(super.error);
}

class SignInFailure extends AuthenticationException {
  const SignInFailure(super.error);
}

class CheckUserExistsFailure extends AuthenticationException {
  const CheckUserExistsFailure(super.error);
}

/// A generic Authentication Client Interface.
/// A generic Authentication Client Interface.
abstract class AuthenticationClient {
  /// A stream of the current user.
  Stream<UserModel> get user;

  /// Registers a new user with the provided email and password.
  Future<void> signUp({required String email, required String password});

  /// Signs in a user with the provided email and password.
  Future<void> signIn({required String email, required String password});

  /// Signs in a user using Google authentication.
  Future<void> signInWithGoogle();

  /// Signs in a user using Apple authentication.
  Future<void> signInWithApple();

  /// Sends a sign-in email link to the provided email address.
  Future<void> signInWithEmailLink({required String email});

  /// Sends a password reset email to the provided email address.
  Future<void> resetPassword({required String email});

  /// Updates the user's profile with the provided name and avatar URL.
  Future<void> updateProfile({String? name, String? avatarUrl});

  /// Signs out the current user.
  Future<void> signOut();

  /// Deletes the account of the current user.
  Future<void> deleteAccount();

  Future<bool> checkUserExists({required String email});
}
