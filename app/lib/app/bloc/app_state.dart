part of 'app_bloc.dart';

enum AppStatus {
  onboardingRequired(),
  authenticated(),
  unauthenticated();

  bool get isLoggedIn => this == AppStatus.authenticated || this == AppStatus.onboardingRequired;
}

class AppState extends Equatable {
  const AppState({required this.status, this.user = UserModel.anonymous, this.showLoginOverlay = false});

  const AppState.authenticated(UserModel user) : this(status: AppStatus.authenticated, user: user);

  const AppState.onboardingRequired(UserModel user) : this(status: AppStatus.onboardingRequired, user: user);

  const AppState.unauthenticated() : this(status: AppStatus.unauthenticated);

  final AppStatus status;
  final UserModel user;
  final bool showLoginOverlay;

  @override
  List<Object?> get props => [status, user, showLoginOverlay];

  AppState copyWith({AppStatus? status, UserModel? user, bool? showLoginOverlay}) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
      showLoginOverlay: showLoginOverlay ?? this.showLoginOverlay,
    );
  }
}
