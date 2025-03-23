part of 'auth_bloc.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading, error }

class AuthState {
  final AuthStatus status;
  final UserModel user;
  final String? errorMessage;
  final bool userExists;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user = UserModel.anonymous,
    this.userExists = false,
    this.errorMessage,
  });

  AuthState copyWith({AuthStatus? status, UserModel? user, String? errorMessage, bool? userExists}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      userExists: userExists ?? this.userExists,
    );
  }
}
